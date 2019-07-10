class Inputs::CreateDog < Inputs::BaseInputObject
  argument :user_id, ID, "The user that the dog belongs to", required: true
  argument :profile_picture, String, "The S3 signed ID of the profile picture for the dog", required: false
  argument :name, String, required: true
  argument :age, Int, required: false
  argument :sex, Types::Sex, required: false
  argument :color, String, required: false
end