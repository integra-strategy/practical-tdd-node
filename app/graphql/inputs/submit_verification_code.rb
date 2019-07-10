class Inputs::SubmitVerificationCode < Inputs::BaseInputObject
  argument :verification_code, Int, "The four digit check-in code that was sent to the user via SMS.", required: true
end