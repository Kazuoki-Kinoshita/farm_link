require 'rails_helper'

RSpec.describe "スケジュール管理機能", type: :system do
  let(:user2) { create(:user2) }
  let!(:farmer) { create(:farmer, user: user2) }
  let!(:experience) { create(:experience, farmer: farmer) }
  let!(:schedule) { create(:schedule, experience: experience) }

  before do
    sign_in user2
  end

  describe "スケジュール作成" do
    context "新しいスケジュールを作成する" do
      it "スケジュールが追加され、表示されること" do
        visit experience_path(experience)

        fill_in "タイトル", with: "New Title"
        select_datetime(DateTime.now + 1.day, from: "schedule_start_time")
        select_datetime(DateTime.now + 1.day + 2.hours, from: "schedule_end_time")

        click_button "スケジュールを追加"
        expect(page).to have_content("スケジュールが追加されました。")
        expect(page).to have_content("New Title")
      end
    end

    context "スケジュールを編集する" do
      it "スケジュールが更新され、表示されること" do
        visit experience_path(experience)
        click_link "編集", match: :first

        fill_in "タイトル", with: "Edited Title"
        select_datetime(DateTime.now + 2.days, from: "schedule_start_time")
        select_datetime(DateTime.now + 2.days + 3.hours, from: "schedule_end_time")

        click_button "更新する"
        expect(page).to have_content("スケジュールが更新されました。")
        expect(page).to have_content("Edited Title")
      end
    end
  end
end