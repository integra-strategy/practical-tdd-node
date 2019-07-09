class Types::ConfirmMember < Types::BaseInputObject
  argument :id, ID, "The ID of the member to confirm", required: true
end