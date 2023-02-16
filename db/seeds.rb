# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#   10.times do |n|
#     User.create!(
#         name: "username#{n + 1}",
#         email: "user#{n + 1}@gmail.com",
#         password: "userpasswordr#{n + 1}",
#         password_confirmation: "userpasswordr#{n + 1}"
#     )
#   end

#   User.create!(name: "Administrator",
#     email: "admin1@example.jp",
#     password: "adminpassword",
#     admin: "true")

  User.create(name: 'user1', email: 'user1@gmail.com', password: 'user1password', password_confirmation: 'user1password')
  User.create(name: 'user2', email: 'user2@gmail.com', password: 'user2password', password_confirmation: 'user2password')
  User.create(name: 'user3', email: 'user3@gmail.com', password: 'user3password', password_confirmation: 'user3password')
  User.create(name: 'user4', email: 'user4@gmail.com', password: 'user4password', password_confirmation: 'user4password')
  User.create(name: 'user5', email: 'user5@gmail.com', password: 'user5password', password_confirmation: 'user5password')
  User.create(name: 'user6', email: 'user6@gmail.com', password: 'user6password', password_confirmation: 'user6password')
  User.create(name: 'user7', email: 'user7@gmail.com', password: 'user7password', password_confirmation: 'user7password')
  User.create(name: 'user8', email: 'user8@gmail.com', password: 'user8password', password_confirmation: 'user8password')
  User.create(name: 'user9', email: 'user9@gmail.com', password: 'user9password', password_confirmation: 'user9password')
  User.create(name: 'user10', email: 'user10@gmail.com', password: 'user10password', password_confirmation: 'user10password')

10.times do |i|
  Task.create!(title: "タスク", content: "課題に取り組む", user_id: 1)
end

10.times do |i|
  Label.create!(label_name: "タスクラベル#{i+1}")
end