FactoryBot.define do
  factory :general do
    name { "Test General" }
    prefecture_id { 1 }
    address { "Test Address" }
    favorite_crop { "Test favorite_crop"}
    association :user
  end
end