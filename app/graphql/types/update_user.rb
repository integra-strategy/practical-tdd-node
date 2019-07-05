class Types::UpdateUser < Types::BaseInputObject
  STEP_DESCRIPTION = "The step of the sign up process that the user has completed. This is used to track what screen the user should be taken back to if they stop the sign up process and then come back to it."
  COMPLETED_DESCRIPTION = "Whether or not the user has completed the sign up process."

  argument :id, ID, required: true
  argument :first_name, String, required: false
  argument :last_name, String, required: false
  argument :authorized_user, String, "The names of users that are authorized to take the user's dog to the park", required: false
  argument :address, String, required: false
  argument :address2, String, required: false
  argument :city, String, required: false
  argument :state, String, required: false
  argument :zip, String, required: false
  argument :step, Int, STEP_DESCRIPTION, required: false
  argument :completed, Boolean, COMPLETED_DESCRIPTION, required: false
  argument :profile_picture, String, "The S3 signed ID of the profile picture for the user", required: false
  argument :accepted_terms, Boolean, "Whether or not the user has accepted the terms and conditions", required: false
  argument :phone_number, String, "10 digit phone number for user", required: false
  argument :package, ID, "The ID of the package on Stripe", required: false
  argument :stripe_card_token, String, "The Stripe ID for the token that represents the user's card on Stripe", required: false
end