require 'rails_helper'

RSpec.describe "一般ユーザー管理機能", type: :system do
  let(:user) { create(:user) }
  let!(:general) { create(:general, user: user) }

  before do
    sign_in user
  end

  describe "CRUD機能作成" do
    context "新しいgeneralを作成する" do
      it "新しいgeneralが作成されること" do
        visit new_general_path

        fill_in "ユーザーネーム", with: "Test General"
        select "北海道", from: "都道府県"
        fill_in "市区町村", with: "Test Address"
        fill_in "好きな農作物", with: "Test favorite_crop"
        click_button "登録する"
        expect(page).to have_content("プロフィールが登録されました")
        expect(page).to have_content("Test General")
        expect(page).to have_content("北海道")
        expect(page).to have_content("Test Address")
        expect(page).to have_content("Test favorite_crop")
      end
    end

    context "generalの詳細ページを表示する" do
      it "generalの詳細ページが表示されること" do
        visit general_path(general)

        expect(page).to have_content(general.name)
        expect(page).to have_content(general.prefecture.name)
        expect(page).to have_content(general.address)
        expect(page).to have_content(general.favorite_crop)
      end
    end

    context "generalを編集する" do
      it "generalの情報が編集されること" do
        visit edit_general_path(general)

        fill_in "ユーザーネーム", with: "Updated General"
        select "東京都", from: "都道府県"
        fill_in "市区町村", with: "Updated Address"
        fill_in "好きな農作物", with: "Updated favorite_crop"
        click_button "更新する"

        expect(page).to have_content("プロフィールが更新されました")
        expect(page).to have_content("Updated General")
        expect(page).to have_content("東京都")
        expect(page).to have_content("Updated Address")
        expect(page).to have_content("Updated favorite_crop")
      end
    end
  end
end