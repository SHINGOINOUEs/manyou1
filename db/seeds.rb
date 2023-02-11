# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do |n|
  User.create!(
      name: "username#{n + 1}",
      email: "user#{n + 1}@gmail.com",
      password: "userpasswordr#{n + 1}",
      password_confirmation: "userpasswordr#{n + 1}"
  )
end

User.create!(name: "Administrator",
  email: "admin1@example.jp",
  password: "adminpassword",
  admin: "true")

