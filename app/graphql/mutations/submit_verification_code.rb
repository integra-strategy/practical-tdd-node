class Mutations::SubmitVerificationCode < Mutations::BaseMutation
  argument :input, Inputs::SubmitVerificationCode, required: true

  field :errors, [Types::UserError], null: false

  def resolve(input:)
    member = Member.find_by(phone_number: input.phone_number)
    errors = get_errors(member, input)
    unless errors.length > 0
      member.update(verification_code: nil, check_in_time: Time.zone.now)
    end
    {errors: errors}
  end

  def get_errors(member, input)
    return [] if member.verification_code == input[:verification_code]
    [{
      path: 'verification_code',
      message: "Verification code doesn't match"
    }]
  end
end