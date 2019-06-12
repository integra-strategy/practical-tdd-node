User.create!(
  first_name: FFaker::Name.first_name,
  last_name: FFaker::Name.last_name,
  email: "employee@example.com",
  password: "password",
  profile_picture: "https://example.com"
)