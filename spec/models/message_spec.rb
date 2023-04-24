require 'rails_helper'

RSpec.describe Message, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:recipient) { FactoryBot.create(:user) }
  let(:conversation) { FactoryBot.create(:conversation, sender: user, recipient: recipient) }
  let(:message) { FactoryBot.build(:message, user: user, conversation: conversation) }

  describe 'バリデーションテスト' do
    context 'bodyが空の場合' do
      it 'バリデーションに引っかかる' do
        message.body = ''
        expect(message).not_to be_valid
      end
    end

    context 'conversation_idが空の場合' do
      it 'バリデーションに引っかかる' do
        message.conversation_id = nil
        expect(message).not_to be_valid
      end
    end

    context 'user_idが空の場合' do
      it 'バリデーションに引っかかる' do
        message.user_id = nil
        expect(message).not_to be_valid
      end
    end

    context '全ての項目が正しく入力されている場合' do
      it 'バリデーションが通る' do
        expect(message).to be_valid
      end
    end
  end
end