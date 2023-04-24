FactoryBot.define do
  factory :message do
    body { "Hello!" }
    association :user
    association :conversation
  end
end
