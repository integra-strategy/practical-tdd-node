class Dog < ApplicationRecord
  belongs_to :user
  enum sex: [Types::Sex::MALE, Types::Sex::FEMALE]
end
