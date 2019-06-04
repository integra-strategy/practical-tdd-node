class Member < ApplicationRecord
  devise :database_authenticatable, :token_authenticatable
end
