FactoryBot.define do
  factory :general do
    name { "Test General" }
    prefecture_id { 1 }
    address { "Test Address" }
    association :user
  end
end