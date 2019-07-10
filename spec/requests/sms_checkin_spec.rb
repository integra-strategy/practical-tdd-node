require 'rails_helper'

RSpec.describe "SMS checkin", type: :request do
  it "checks a member in", :focus do
    sms_double = instance_double(Sms, send_sms: true)
    allow(Sms).to receive(:new) { sms_double }
    member = create(:member, phone_number: '8138989539')

    send_verification_code(member)
    result = submit_verification_code(member)

    expect(sms_double).to have_received(:send_sms).with({body: member.verification_code, to: member.phone_number })
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
    graphql(query: mutation, variables: OpenStruct.new(input: {phone_number: member.phone_number}), user: member)
  end

  def submit_verification_code(member)
    member.reload
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
    graphql(query: mutation, variables: OpenStruct.new(input: {verification_code: member.verification_code}), user: member)
  end
end