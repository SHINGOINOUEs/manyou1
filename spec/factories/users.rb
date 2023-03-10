FactoryBot.define do
  factory :user do
    name { 'Administrator' }
    email { 'admin@example.com' }
    password { 'adminpassword' }
    password_confirmation { 'adminpassword' }
    admin { true }
  end
  
  factory :second_user , class: User do
    name { 'user1'}
    email { 'user1@example.com' }
    password { 'user1password' }
    password_confirmation { 'user1password' }
    admin { 'false' }
  end
end
