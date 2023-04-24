require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let(:user1) { FactoryBot.create(:user) }
  let(:user2) { FactoryBot.create(:user) }
  let(:relationship) { FactoryBot.build(:relationship, follower: user1, followed: user2) }

  describe 'バリデーションテスト' do
    context 'follower_idが空の場合' do
      it 'バリデーションに引っかかる' do
        relationship.follower_id = nil
        expect(relationship).not_to be_valid
      end
    end

    context 'followed_idが空の場合' do
      it 'バリデーションに引っかかる' do
        relationship.followed_id = nil
        expect(relationship).not_to be_valid
      end
    end

    context 'follower_idとfollowed_idが存在する場合' do
      it 'バリデーションが通る' do
        expect(relationship).to be_valid
      end
    end
  end
end
