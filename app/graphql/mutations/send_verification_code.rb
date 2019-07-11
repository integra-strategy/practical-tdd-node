class Mutations::SendVerificationCode < Mutations::BaseMutation
  argument :input, Inputs::SendVerificationCode, required: true

  field :errors, [Types::UserError], null: false

  def resolve(input:)
    member = Member.find_by(phone_number: input[:phone_number])
    unless member.confirmed?
      return { errors: [{ path: 'checkIn', message: "There was a problem checking-in. Please see an employee." }] }
    end
    verification_code = rand(1000..9999)
    sms = Sms.new
    sms.send_sms(
      to: member.phone_number,
      body: member.verification_code
    )
    if sms.successful?
      member.update(verification_code: verification_code)
    end
    { errors: sms.errors }
  end
end