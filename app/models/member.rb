class Member < ApplicationRecord
  devise :database_authenticatable, :token_authenticatable
  attr_accessor :first_name
end
