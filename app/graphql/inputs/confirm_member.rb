class Inputs::ConfirmMember < Inputs::BaseInputObject
  argument :id, ID, "The ID of the member to confirm", required: true
end