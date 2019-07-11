class Mutations::SendVerificationCode < Mutations::BaseMutation
  argument :input, Inputs::SendVerificationCode, required: true

  field :errors, [Types::UserError], null: false

  def resolve(input:)
    member = Member.find_by(phone_number: input[:phone_number])
    verification_code = rand(1000..9999)
    member.update(verification_code: verification_code)
    sms = Sms.new
    sms.send_sms(
      to: member.phone_number,
      body: member.verification_code
    )
    { errors: sms.errors }
  end
end