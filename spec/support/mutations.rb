module Fetch
  module Mutations
    def sign_in_mutation
      <<~GQL
        mutation SignIn($email: String!, $password: String!) {
          signIn(email: $email, password: $password) {
            auth {
              authenticationToken
            }
            user {
              id
            }
          }
        }
      GQL
    end

    def send_verification_code(member)
      mutation = <<~GQL
        mutation SendVerificationCode($input: SendVerificationCode!) {
          sendVerificationCode(input: $input) {
            errors {
              path
              message
            }
          }
        }
      GQL
      result = graphql(
        query: mutation,
        variables: OpenStruct.new(
          input: {
            phone_number: member.phone_number
            }
          ),
        user: member
      )
      member.reload
      result.data.send_verification_code
    end
  
    def submit_verification_code(member)
      mutation = <<~GQL
        mutation SubmitVerificationCode($input: SubmitVerificationCode!) {
          submitVerificationCode(input: $input) {
            errors {
              path
              message
            }
          }
        }
      GQL
      variables = OpenStruct.new(
        input: {
          verification_code: member.verification_code,
          phone_number: member.phone_number
        }
      )
      result = graphql(query: mutation, variables: variables, user: member)
      member.reload
      result.data.submit_verification_code
    end
  end
end