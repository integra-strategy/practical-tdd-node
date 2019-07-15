require 'rails_helper'

RSpec.describe "Sign up", type: :request do
  it "supports signing up with basic info" do
    variables = {
      email: 'someemail@example.com',
      password: 'password'
    }

    result = create_manager(variables).user

    expect(result.email).to eq(variables[:email])
  end

  def create_manager(variables)
    mutation = <<~GQL
      mutation CreateManager($input: CreateManager!) {
        createManager(input: $input) {
          user {
            email
          }
          errors {
            path
            message
          }
        }
      }
    GQL

    graphql(query: mutation, variables: OpenStruct.new(input: variables)).data.create_manager
  end
end