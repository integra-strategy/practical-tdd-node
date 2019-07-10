class Mutations::SubmitVerificationCode < Mutations::BaseMutation
  argument :input, Inputs::SubmitVerificationCode, required: true

  field :errors, [Types::UserError], null: false

  def resolve(input:)
    {errors: []}
  end
end