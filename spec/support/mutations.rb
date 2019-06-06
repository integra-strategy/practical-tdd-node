module Fetch
  module Mutations
    def sign_in_mutation(email:, password:)
      <<~GQL
        mutation SignIn {
          signIn(email: "#{email}", password: #{password}) {
            authenticationToken
          }
        }
      GQL
    end
  end
end