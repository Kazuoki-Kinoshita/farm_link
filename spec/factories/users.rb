FactoryBot.define do
  factory :user do
    name { "Test User" }
    sequence(:email) { |n| "test#{n}@example.com" }
    password { "password" }
    role { "general" }
  end

  factory :user2, class: User do
    name { 'Test User' }
    sequence(:email) { |n| "test#{n}@example.com" }
    password { 'password' }
    role { 'farmer' }
  end
end