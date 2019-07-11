require 'rails_helper'

RSpec.describe "SMS checkin", type: :request do
  it "checks a member in" do
    stub_sms
    member = create(:member, :with_phone_number)

    send_verification_code(member)
    expect(member.verification_code).not_to be_nil

    result = submit_verification_code(member)
    expect(result.errors.count).to eq(0)
    expect(member.verification_code).to be_nil
  end

  it "returns an error when the verification code doesn't match" do
    stub_sms
    member = create(:member, :with_phone_number)
    send_verification_code(member)

    member.verification_code = member.verification_code + 1
    result = submit_verification_code(member)

    error = result.errors.first
    expect(error.path).to eq('verification_code')
    expect(error.message).to eq("Verification code doesn't match")
    expect(member.verification_code).not_to be_nil
  end

  it "returns an error when the Twilio request fails" do
    stub_sms(status: 400)
    member = build(:member, :with_phone_number)
    member.save(validate: false)
    result = send_verification_code(member)

    error = result.errors.first
    expect(error.path).to eq('check_in')
    expect(error.message).to eq("There was a problem checking-in. Please see an employee.")
    expect(member.verification_code).to be_nil
  end

  it "returns an error when the member hasn't been confirmed" do
    stub_sms
    member = create(:member, :with_phone_number, unconfirmed: true)
    result = send_verification_code(member)

    error = result.errors.first
    expect(error.path).to eq('checkIn')
    expect(error.message).to eq("There was a problem checking-in. Please see an employee.")
    expect(member.verification_code).to be_nil
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
    result = graphql(
      query: mutation,
      variables: OpenStruct.new(
        input: {
          phone_number: member.phone_number
          }
        ),
      user: member
    )
    member.reload
    result.data.send_verification_code
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

  def stub_sms(status: 200)
    stub_twilio_request.to_return(status: status, body: "", headers: {})
  end

  def stub_twilio_request
    stub_request(:post, "#{ENV['TWILIO_API_URL']}/Messages.json").
      with(
        body: { "Body"=> nil, "From"=> ENV['TWILIO_PHONE_NUMBER'], "To"=>/\d+/ },
      )
  end
end