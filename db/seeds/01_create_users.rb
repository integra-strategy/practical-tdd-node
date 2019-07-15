member = Member.new(
  first_name: "John",
  last_name: "Doe",
  email: "member@example.com",
  password: "password"
)
member.skip_confirmation!
member.save

employee = Employee.new(
  first_name: 'Jane',
  last_name: 'Doe',
  email: 'employee@example.com',
  password: 'password'
)
employee.skip_confirmation!
employee.save

manager = Manager.new(
  first_name: 'Jim',
  last_name: 'Doe',
  email: 'manager@example.com',
  password: 'password'
)
manager.skip_confirmation!
manager.save

admin = Admin.new(
  first_name: 'Terra',
  last_name: 'Doe',
  email: 'admin@example.com',
  password: 'password'
)
admin.skip_confirmation!
admin.save