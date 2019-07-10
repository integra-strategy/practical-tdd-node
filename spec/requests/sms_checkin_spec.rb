require 'rails_helper'

RSpec.describe "SMS checkin", type: :request do
  it "checks a member in" do
    sms_double = stub_sms
    member = create(:member, phone_number: '8138989539')

    send_verification_code(member)
    expect(member.verification_code).not_to be_nil
    expect(sms_double).to have_received(:send_sms).
      with({ body: member.verification_code, to: member.phone_number })

    result = submit_verification_code(member)
    expect(result.errors.count).to eq(0)
    expect(member.verification_code).to be_nil
  end

  it "returns an error when the verification code doesn't match" do
    sms_double = stub_sms
    member = create(:member, phone_number: '8138989539')
    send_verification_code(member)

    member.verification_code = member.verification_code + 1
    result = submit_verification_code(member)

    error = result.errors.first
    expect(error.path).to eq('verification_code')
    expect(error.message).to eq("Verification code doesn't match")
    expect(member.verification_code).not_to be_nil
  end

  def send_verification_code(member)
    mutation = <<~GQL
      mutation SendVerificationCode($input: SendVerificationCode!) {
        sendVerificationCode(input: $input) {
          errors {
            path
            message
          }
        }
      }
    GQL
    graphql(query: mutation, variables: OpenStruct.new(input: {phone_number: member.phone_number}), user: member).tap do
      member.reload
    end
  end

  def submit_verification_code(member)
    mutation = <<~GQL
      mutation SubmitVerificationCode($input: SubmitVerificationCode!) {
        submitVerificationCode(input: $input) {
          errors {
            path
            message
          }
        }
      }
    GQL
    variables = OpenStruct.new(
      input: {
        verification_code: member.verification_code,
        phone_number: member.phone_number
      }
    )
    result = graphql(query: mutation, variables: variables, user: member)
    member.reload
    result.data.submit_verification_code
  end

  def stub_sms
    instance_double(Sms, send_sms: true).tap do |sms_double|
      allow(Sms).to receive(:new) { sms_double }
    end
  end
end