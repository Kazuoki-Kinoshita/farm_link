FactoryBot.define do
  factory :plot do
    name { 'Test Plot' }
    association :farmer
  end
end

