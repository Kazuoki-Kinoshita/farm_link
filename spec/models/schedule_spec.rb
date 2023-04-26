require 'rails_helper'

RSpec.describe Schedule, type: :model do
  let(:user2) { FactoryBot.create(:user2) }
  let(:farmer) { FactoryBot.create(:farmer, user: user2) }
  let!(:plot) { FactoryBot.create(:plot) }
  let(:experience) { FactoryBot.create(:experience, farmer: farmer, plot_ids: [plot.id]) }
  let(:schedule) { FactoryBot.build(:schedule, experience: experience) }

  describe 'バリデーションテスト' do
    context 'タイトルが空の場合' do
      it 'バリデーションに引っかかる' do
        schedule.title = nil
        expect(schedule).not_to be_valid
      end
    end

    context 'タイトルが15文字より長い場合' do
      it 'バリデーションに引っかかる' do
        schedule.title = 'a' * 16
        expect(schedule).not_to be_valid
      end
    end

    context '開始時間が終了時間と同じかそれ以上の場合' do
      it 'バリデーションに引っかかる' do
        time_now = Time.current.round 
        schedule.start_time = time_now
        schedule.end_time = time_now
        expect(schedule).not_to be_valid
      end
    end
    
    context '全ての属性が正しい場合' do
      it 'バリデーションが通る' do
        expect(schedule).to be_valid
      end
    end
  end

  describe 'スコープ' do
    it '保存されたスケジュールのみを返す' do
      schedule1 = FactoryBot.create(:schedule, experience: experience)
      schedule2 = FactoryBot.create(:schedule, experience: experience)
      expect(Schedule.saved).to match_array([schedule1, schedule2])
    end
  end
end