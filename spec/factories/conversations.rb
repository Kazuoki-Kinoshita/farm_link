FactoryBot.define do
  factory :conversation do
    association :sender, factory: :user
    association :recipient, factory: :user2

    after(:build) do |conversation|
      while conversation.sender_id == conversation.recipient_id
        conversation.recipient = FactoryBot.create(:user)
      end
    end
  end
end
