module Fetch
  module Queries
    def user_detail_query
      <<~GQL
        query UserDetail($id:ID!) {
          userDetail(id:$id) {
            firstName
            dogs {
              id
            }
            package {
              id
              name
              amount
            }
            subscriptionActive
          }
        }
      GQL
    end
  end
end