module Fetch
  module Queries
    def user_detail_query
      <<~GQL
        query UserDetail {
          userDetail {
            firstName
          }
        }
      GQL
    end
  end
end