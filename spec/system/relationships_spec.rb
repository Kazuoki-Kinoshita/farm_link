require 'rails_helper'

RSpec.describe 'フォロー管理機能', type: :system do
  describe "フォロー機能" do
    let!(:user) { create(:user2, email: 'user1@example.com') }
    let!(:farmer) { create(:farmer, user: user) }
    let!(:other_user) { create(:user, email: 'user2@example.com') }
    let!(:general) { create(:general, user: other_user) }

    before do
      sign_in user
    end

    context '他のユーザーをフォローする場合' do
      it 'ユーザーをフォローする' do
        visit general_path(general)
        click_button 'commit'
        expect(user.following?(other_user)).to be_truthy
      end
    end

    context 'フォローしているユーザーのフォローを解除する場合' do
      before do
        user.follow!(other_user)
      end

      it 'ユーザーのフォローを解除する' do
        visit general_path(general)
        click_button 'commit'
        expect(user.following?(other_user)).to be_falsey
      end
    end
  end

  describe "フォロー機能" do
    let!(:user) { create(:user2, email: 'user1@example.com') }
    let!(:other_user) { create(:user, email: 'user2@example.com') }
    let!(:general) { create(:general, user: other_user) }

    before do
      sign_in user
    end

    context 'プロフィール登録していないユーザーがフォローを押した場合' do
      it 'プロフィール登録画面にリダイレクトされる' do
        visit general_path(general)
        click_button 'commit'
        expect(page).to have_content("プロフィール登録をお願いします")
      end
    end
  end
end