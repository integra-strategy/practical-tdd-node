class User < ApplicationRecord
  devise :database_authenticatable, :token_authenticatable
end
