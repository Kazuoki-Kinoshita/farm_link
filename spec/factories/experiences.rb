FactoryBot.define do
  factory :experience do
    title { "Example Experience Title" }
    content { "Example Experience Content" }
    association :farmer
    
    after(:build) do |experience|
      experience.plots << experience.farmer.plots.first
    end
  end
end
