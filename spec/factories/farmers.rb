FactoryBot.define do
  factory :farmer do
    name { 'Test Farmer' }
    prefecture_id { 1 }
    address { 'Test Address' }
    station { 'Test Station' }
    product { 'Test Product' }
    website { 'https://example.com' }
    profile { 'Test Profile' }
    association :user, factory: :user2
    
    after(:build) do |farmer|
      farmer.plots << build(:plot, farmer: farmer)
    end
  end
end