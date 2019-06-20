member = Member.new(
  first_name: "John",
  last_name: "Doe",
  email: "member@example.com",
  password: "password",
  profile_picture: "https://example.com"
)
member.skip_confirmation!
member.save

employee = Employee.new(
  first_name: 'Jane',
  last_name: 'Doe',
  email: 'employee@example.com',
  password: 'password',
  profile_picture: 'https://example.com'
)
employee.skip_confirmation!
employee.save