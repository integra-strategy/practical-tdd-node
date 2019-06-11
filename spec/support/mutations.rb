module Fetch
  module Mutations
    def sign_in_mutation
      <<~GQL
        mutation SignIn($email: String!, $password: String!) {
          signIn(email: $email, password: $password) {
            authenticationToken
          }
        }
      GQL
    end
  end
end