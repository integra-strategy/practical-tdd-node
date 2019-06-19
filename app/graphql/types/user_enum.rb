class Types::UserEnum < Types::BaseEnum
  description 'The type of user'

  MEMBER = :Member
  EMPLOYEE = :Employee

  value MEMBER, 'A member'
  value EMPLOYEE, 'An employee'
end