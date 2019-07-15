class Inputs::CreateManager < Inputs::BaseInputObject
  argument :email, String, "The email for the member", required: true
  argument :password, String, "The password for the member", required: true
end