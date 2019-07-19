class Mutations::SendVerificationCode < Mutations::BaseMutation
  argument :input, Inputs::SendVerificationCode, required: true

  field :errors, [Types::UserError], null: false

  def resolve(input:)
    member = User.find_by(phone_number: input[:phone_number]).cast
    unless member.confirmed? && member.subscription_active? && member.dogs_vaccinations_current? && member.active?
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