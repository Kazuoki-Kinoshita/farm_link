require 'rails_helper'

RSpec.describe "管理者機能", type: :system do
  let(:admin) { create(:user, :admin) }

  describe '管理者アクセス' do
    context '管理者がログインしたとき' do
      before do
        sign_in admin
        visit rails_admin_path
      end

      it 'RailsAdminへのアクセスを許可する' do
        expect(current_path).to eq rails_admin_path
        expect(page).to have_content('サイト管理')
      end
    end
  end
end