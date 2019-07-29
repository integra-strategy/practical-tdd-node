require 'rails_helper'

RSpec.describe "SMS checkin", type: :request do
  it "checks a member in" do
    stub_sms
    member = create(:member, :with_phone_number, create_subscription: true)

    send_verification_code(member)
    expect(member.verification_code).not_to be_nil

    result = submit_verification_code(member)
    expect(result.errors.count).to eq(0)
    expect(member.verification_code).to be_nil
  end

  it "returns an error when the verification code doesn't match" do
    stub_sms
    member = create(:member, :with_phone_number, create_subscription: true)
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
    expect(error.path).to eq('checkIn')
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

  it "returns an error when the member hasn't been confirmed" do
    stub_sms
    member = create(:member, :with_phone_number, create_subscription: false)
    result = send_verification_code(member)

    error = result.errors.first
    expect(error.path).to eq('checkIn')
    expect(error.message).to eq("There was a problem checking-in. Please see an employee.")
    expect(member.verification_code).to be_nil
  end

  it "returns an error when the user has a dog without outdated vaccine records" do
    stub_sms
    member = create(:member, :with_phone_number, create_subscription: true)
    dog = create(:dog, user: member, rabies: Time.now - 1.day)
    result = send_verification_code(member)

    error = result.errors.first
    expect(error.path).to eq('checkIn')
    expect(error.message).to eq("There was a problem checking-in. Please see an employee.")
    expect(member.verification_code).to be_nil
  end

  it "doesn't allow deactivated users to check-in" do
    member = create(:member, :with_phone_number, create_subscription: true, deactivated: true)
    result = send_verification_code(member)

    error = result.errors.first
    expect(error.path).to eq('checkIn')
    expect(error.message).to eq("There was a problem checking-in. Please see an employee.")
    expect(member.verification_code).to be_nil
  end
end