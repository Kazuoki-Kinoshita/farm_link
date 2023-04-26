require 'rails_helper'

RSpec.describe "体験情報管理機能", type: :system do
  let(:user2) { create(:user2) }
  let!(:farmer) { create(:farmer, user: user2) }
  let!(:experience) { create(:experience, farmer: farmer) }

  before do
    sign_in user2
  end

  describe "CRUD機能作成" do
    context "新しい体験情報を作成する" do
      it "新しい体験情報が作成されること" do
        visit new_experience_path
        check "Test Plot"
        fill_in "タイトル", with: "Test Experience Title"
        fill_in "体験情報", with: "Test Experience Content"
        click_button "登録する"
        expect(page).to have_content("体験情報が保存されました。")
        expect(page).to have_content("Test Experience Title")
        expect(page).to have_content("Test Experience Content")
      end
    end

    context "体験情報の詳細を表示する" do
      it "体験情報の詳細が表示されること" do
        visit experience_path(experience)
        expect(page).to have_content(experience.title)
        expect(page).to have_content(experience.content)
      end
    end

    context "体験情報の情報を編集する" do
      it "体験情報が編集されること" do
        visit edit_experience_path(experience)
        fill_in "タイトル", with: "Updated Experience Title"
        fill_in "体験情報", with: "Updated Experience Content"
        click_button "更新する"
        expect(page).to have_content("体験情報が更新されました")
        expect(page).to have_content("Updated Experience Title")
        expect(page).to have_content("Updated Experience Content")
      end
    end

    context "体験情報が一覧に表示される" do
      it "体験情報一覧が表示されること" do
        visit experiences_path
        expect(page).to have_content(experience.title)
        expect(page).to have_content(experience.content)
      end
    end

    context "新しく登録された体験情報が一番最初に表示される" do
      it "新しい体験情報が最初に表示されること" do
        create(:experience, title: "Newly Added Experience", content: "Newly Added Experience Content", farmer: farmer)
        visit new_experience_path
        click_button "登録する"
        visit experiences_path
        within(".card:first-of-type") do
          expect(page).to have_text("Newly Added Experience")
          expect(page).to have_text("Newly Added Experience Content")
        end
      end
    end

    context "体験情報を削除する" do
      it "体験情報が削除されること" do
        create(:experience, title: "Newly Added Experience", content: "Newly Added Experience Content", farmer: farmer)
        visit experiences_path
        click_link "削除", match: :first
        expect(page).not_to have_content(experience.title)
        expect(page).not_to have_content(experience.content)
      end
    end
  end
end