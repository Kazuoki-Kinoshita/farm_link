require 'rails_helper'

RSpec.describe "農家管理機能", type: :system do
  let(:user2) { create(:user2) }
  let!(:farmer) { create(:farmer, user: user2) }

  before do
    sign_in user2
  end

  describe "CRUD機能作成" do
    context "新しいfarmerを作成する" do
      it "新しいfarmerを作成する" do
        visit new_farmer_path
        fill_in "農園・農家名", with: "Test Farmer"
        select "北海道", from: "farmer[prefecture_id]"
        fill_in "住所", with: "Test Address"
        fill_in "最寄り駅", with: "Test Station"
        fill_in "農地カテゴリ", with: "Test Plot"
        fill_in "農作物", with: "Test Product"
        fill_in "Webサイト", with: "https://example.com"
        fill_in "詳細情報", with: "Test Profile"
        click_button "登録する"
        expect(page).to have_content("プロフィールが登録されました")
        expect(page).to have_content("Test Farmer")
        expect(page).to have_content("北海道")
        expect(page).to have_content("Test Address")
        expect(page).to have_content("Test Station")
        expect(page).to have_content("Test Plot")
        expect(page).to have_content("Test Product")
        expect(page).to have_content("https://example.com")
        expect(page).to have_content("Test Profile")
      end
    end

    context "farmerの詳細ページを表示する" do  
      it "farmerの詳細を表示する" do
        visit farmer_path(farmer)
        expect(page).to have_content(farmer.name)
        expect(page).to have_content(farmer.prefecture_id)
        expect(page).to have_content(farmer.address)
        expect(page).to have_content(farmer.station)
        expect(page).to have_content(farmer.plots.name)
        expect(page).to have_content(farmer.product)
        expect(page).to have_content(farmer.website)
        expect(page).to have_content(farmer.profile)
      end
    end

    context "farmerを編集する" do
      it "farmerの情報を編集する" do
        visit edit_farmer_path(farmer)

        fill_in "農園・農家名", with: "Updated Farmer"
        select "東京都", from: "farmer[prefecture_id]"
        fill_in "住所", with: "Updated Address"
        fill_in "最寄り駅", with: "Updated Station"
        fill_in "農地カテゴリ", with: "Updated Plot"
        fill_in "農作物", with: "Updated Product"
        fill_in "Webサイト", with: "https://updated.example.com"
        fill_in "詳細情報", with: "Updated Profile"
        click_button "更新する"

        expect(page).to have_content("プロフィールが更新されました")
        expect(page).to have_content("Updated Farmer")
        expect(page).to have_content("東京都")
        expect(page).to have_content("Updated Address")
        expect(page).to have_content("Updated Station")
        expect(page).to have_content("Updated Plot")
        expect(page).to have_content("Updated Product")
        expect(page).to have_content("https://updated.example.com")
        expect(page).to have_content("Updated Profile")
      end
    end

    context "新しく登録されたfarmerが一番最初に表示される" do
      it "新しく登録されたfarmerが一番最初に表示される" do
        farmer1 = create(:farmer, user: user2, name: "First Farmer", created_at: 1.day.ago)
        farmer2 = create(:farmer, user: user2, name: "Newly Added Farmer")
      
        visit farmers_path
        within(".row") do
          expect(page).to have_text(/Newly Added Farmer.*First Farmer/m)
        end
      end
    end

    context "詳細ページに作成したFarmerの情報が表示される" do
      it "詳細ページに作成したFarmerの情報が表示される" do
        farmer
        visit farmers_path
        click_link "詳細", match: :first
        expect(page).to have_current_path(overview_farmer_path(farmer))
        expect(page).to have_content("Test Farmer")
      end
    end
  end
end