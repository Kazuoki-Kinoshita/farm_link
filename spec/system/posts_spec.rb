require 'rails_helper'

RSpec.describe "投稿管理機能", type: :system do
  let(:user2) { create(:user2) }
  let!(:farmer) { create(:farmer, user: user2) }
  let!(:post) { create(:post, farmer: farmer) }

  before do
    sign_in user2
  end

  describe "CRUD機能作成" do
    context "新しい投稿を作成する" do
      it "正常に登録が完了する" do
        visit new_post_path
        fill_in "タイトル", with: "Test Title"
        fill_in "内容", with: "Test Content"
        click_button "登録する"
        expect(page).to have_content("投稿が保存されました。")
        expect(page).to have_content("Test Title")
        expect(page).to have_content("Test Content")
      end
    end

    context "投稿の詳細を表示する" do
      it "正常に表示される" do
        visit post_path(post)
        expect(page).to have_content(post.title)
        expect(page).to have_content(post.content)
      end
    end

    context "投稿の情報を編集する" do
      it "正常に更新が完了する" do
        visit edit_post_path(post)
        fill_in "タイトル", with: "Updated Post Title"
        fill_in "内容", with: "Updated Post Content"
        click_button "更新する"
        expect(page).to have_content("投稿が更新されました")
        expect(page).to have_content("Updated Post Title")
        expect(page).to have_content("Updated Post Content")
      end
    end

    context "投稿が一覧に表示される" do
      it "正常に表示される" do
        visit posts_path
        expect(page).to have_content(post.title)
        expect(page).to have_content(post.content)
      end
    end
    
    context "新しく登録された投稿が一番最初に表示される" do
      it "正常に表示される" do
        create(:post, title: "First Post", content: "First Post Content", farmer: farmer)
        visit new_post_path
        fill_in "タイトル", with: "Newly Added Post"
        fill_in "内容", with: "Newly Added Post Content"
        click_button "登録する"
        visit posts_path
        within(".card:first-of-type") do
          expect(page).to have_text("Newly Added Post")
          expect(page).to have_text("Newly Added Post Content")
        end
      end
    end
    
    context "投稿を削除する" do
      it "正常に削除が完了する" do
        create(:post, title: "First Post", content: "First Post Content", farmer: farmer)
        visit posts_path
        click_link "削除", match: :first
        expect(page).not_to have_content(post.title)
        expect(page).not_to have_content(post.content)
      end
    end
  end
end