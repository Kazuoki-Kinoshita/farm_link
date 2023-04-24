FactoryBot.define do
  factory :schedule do
    association :experience
    title { "Tesr Title" }
    start_time { Time.now }
    end_time { Time.now + 2.hours }
  end
end
