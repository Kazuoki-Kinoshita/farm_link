require 'rails_helper'

RSpec.describe Conversation, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:recipient) { FactoryBot.create(:user) }
  let(:conversation) { FactoryBot.build(:conversation, sender: user, recipient: recipient) }

  describe 'バリデーションテスト' do
    context '同じsender_idとrecipient_idの組み合わせが既に存在する場合' do
      it 'バリデーションに引っかかる' do
        FactoryBot.create(:conversation, sender: user, recipient: recipient)
        expect(conversation).not_to be_valid
      end
    end

    context 'sender_idとrecipient_idが存在し、既存の組み合わせがない場合' do
      it 'バリデーションが通る' do
        expect(conversation).to be_valid
      end
    end
  end
end