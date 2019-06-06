require 'rails_helper'

RSpec.describe "Member sign in", type: :request do
  it "returns an authentication token" do
    email = 'someemail@example.com'
    password = 'password'
    member = create(:member, email: email, password: password)

    result = graphql(query: sign_in_mutation(email: email, password: password), operation_name: 'SignIn')

    expect(result.errors).to be_nil
    expect(result.data.sign_in.authentication_token).to be_truthy
  end
end