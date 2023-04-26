require 'rails_helper'

RSpec.describe 'ユーザ管理機能', type: :system do 
  let!(:user) { FactoryBot.create(:user) }

  describe 'CRUD機能' do
    context 'ユーザ（農家の方）が新規作成した場合' do
      it '新規作成したユーザのプロフィール登録画面（農家の方）が表示される' do
        visit new_user_registration_path
        find("label[for='role_farmer']").click
        fill_in 'user_name', with: 'new_name'
        fill_in 'user_email', with: 'new@yahoo.co.jp'
        fill_in 'user_password', with: 'new1new1'
        fill_in 'user_password_confirmation', with: 'new1new1'
        click_button 'アカウント登録'
        expect(page).to have_content 'アカウント登録が完了しました。次はプロフィール登録をしましょう！'
        expect(page).to have_content '農園・農家名'
      end
    end

    context 'ユーザ（一般の方）が新規作成した場合' do
      it '新規作成したユーザのプロフィール登録画面（一般の方）が表示される' do
        visit new_user_registration_path
        find("label[for='role_general']").click
        fill_in 'user_name', with: 'g_new_name'
        fill_in 'user_email', with: 'g_new@yahoo.co.jp'
        fill_in 'user_password', with: 'g_new1new1'
        fill_in 'user_password_confirmation', with: 'g_new1new1'
        click_button 'アカウント登録'
        expect(page).to have_content 'アカウント登録が完了しました。次はプロフィール登録をしましょう！'
        expect(page).to have_content 'ユーザーネーム'
      end
  
      context 'ログインしたユーザが自分の詳細画面にアクセスした場合' do
        it 'ユーザの詳細情報が表示される' do
          sign_in user
          visit user_path(user)
          expect(page).to have_content(user.name)
          expect(page).to have_content(user.email)
        end
      end

      context 'ログインしたユーザが自分の編集画面にアクセスした場合' do
        it 'ユーザの情報を編集できる' do
          sign_in user
          visit edit_user_registration_path
          fill_in 'user_name', with: 'Updated User Name'
          fill_in 'user_email', with: 'updated_user@example.com'
          fill_in 'user_password', with: 'new_password'
          fill_in 'user_password_confirmation', with: 'new_password'
          fill_in 'user_current_password', with: user.password
          click_button '更新'
          expect(page).to have_content('アカウント情報を変更しました。')
        end
      end
    end
  end    
    
  describe 'ログイン機能' do
    let!(:user2) { FactoryBot.create(:user2) }
    before do
      visit new_user_session_path
      fill_in 'user_email', with: user2.email
      fill_in 'user_password', with: user2.password
      click_button 'ログイン'
    end
    context 'ユーザがログインした場合' do
      it 'ユーザのアカウント詳細画面に飛び「ログインしました。」が表示される' do
        expect(page).to have_content 'ログアウト'
        expect(page).to have_content 'ログインしました。'
      end
    end
  end
end