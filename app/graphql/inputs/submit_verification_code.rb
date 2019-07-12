class Inputs::SubmitVerificationCode < Inputs::BaseInputObject
  argument :phone_number, String, "The 10 digit phone number of the account to verify", required: true
  argument :verification_code, Int, "The four digit check-in code that was sent to the user via SMS.", required: true
end