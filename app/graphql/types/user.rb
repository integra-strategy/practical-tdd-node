class Types::User < Types::BaseObject

  description 'User type for members and employees'

  STEP_DESCRIPTION = "The step of the sign up process that the user has completed. This is used to track what screen the user should be taken back to if they stop the sign up process and then come back to it."
  COMPLETED_DESCRIPTION = "Whether or not the user has completed the sign up process."

  field :id, ID, null: false
  field :type, Types::UserEnum, null: false
  field :email, String, null: false
  field :first_name, String, null: true
  field :last_name, String, null: true
  field :authorized_user, String, "The names of users that are authorized to take the user's dog to the park", null: true
  field :phone_number, String, "10 digit phone number for user", null: true
  field :accepts_sms, Boolean, "whether or not the user has agreed to receive SMS for updates and specials", null: true
  field :profile_picture, Types::File, "The signed ID of the file from AWS S3", null: true
  field :address, String, null: true
  field :address2, String, null: true
  field :city, String, null: true
  field :state, String, null: true
  field :zip, String, null: true
  field :step, Int, STEP_DESCRIPTION, null: true
  field :completed, Boolean, COMPLETED_DESCRIPTION, null: true
  field :accepted_terms, Boolean, "Whether or not the user has accepted the terms and conditions", null: true
  field :package, Types::Package, "The payment package that the user selected when signing up", null: true
  field :dogs, [Types::Dog], "The dogs that belong to the user", null: true
  field :confirmed, Boolean, "Whether or not the user has been confirmed by an employee", null: true
end