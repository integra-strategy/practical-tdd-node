class Inputs::SendVerificationCode < Inputs::BaseInputObject
  argument :phone_number, String, "The 10 digit phone number of the user to send the verification code to", required: true
end