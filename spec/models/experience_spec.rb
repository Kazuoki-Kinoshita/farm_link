require 'rails_helper'

RSpec.describe Experience, type: :model do
  let(:user2) { FactoryBot.create(:user2) }
  let(:farmer) { FactoryBot.create(:farmer, user: user2) }
  let!(:plot) { FactoryBot.create(:plot) }
  let(:experience) { FactoryBot.build(:experience, farmer: farmer, plot_ids: [plot.id]) }

  describe 'バリデーションテスト' do
    context 'タイトルが空の場合' do
      it 'バリデーションに引っかかる' do
        experience.title = ''
        expect(experience).not_to be_valid
      end
    end

    context 'タイトルが256文字以上の場合' do
      it 'バリデーションに引っかかる' do
        experience.title = 'a' * 256
        expect(experience).not_to be_valid
      end
    end

    context 'タイトルが255文字以内の場合' do
      it 'バリデーションが通る' do
        experience.title = 'a' * 255
        expect(experience).to be_valid
      end
    end

    context 'コンテンツが空の場合' do
      it 'バリデーションに引っかかる' do
        experience.content = ''
        expect(experience).not_to be_valid
      end
    end

    context '画像が5枚以上添付されている場合' do
      it 'バリデーションに引っかかる' do
        5.times do |i|
          file_path = Rails.root.join('spec', 'fixtures', 'example.jpg')
          experience.images.attach(io: File.open(file_path), filename: "example_#{i}.jpg", content_type: 'image/jpeg')
        end
        expect(experience).not_to be_valid
      end
    end

    context '画像が4枚以内添付されている場合' do
      it 'バリデーションが通る' do
        4.times do |i|
          file_path = Rails.root.join('spec', 'fixtures', 'example.jpg')
          experience.images.attach(io: File.open(file_path), filename: "example_#{i}.jpg", content_type: 'image/jpeg')
        end
        expect(experience).to be_valid
      end
    end

    context '関連付けられた農地カテゴリがない場合' do
      it 'バリデーションに引っかかる' do
        experience.plot_ids = []
        expect(experience).not_to be_valid
      end
    end

    context '全ての項目が正しく入力されている場合' do
      it 'バリデーションが通る' do
        expect(experience).to be_valid
      end
    end
  end

  describe 'scopes' do
    let!(:experience1) { FactoryBot.create(:experience, farmer: farmer, plot_ids: [plot.id], created_at: 2.days.ago) }
    let!(:experience2) { FactoryBot.create(:experience, farmer: farmer, plot_ids: [plot.id], created_at: 1.day.ago) }
    let!(:experience3) { FactoryBot.create(:experience, farmer: farmer, plot_ids: [plot.id], created_at: Time.now) }

    describe '.created_at_sorted' do
      it 'created_atの降順でExperiencesを取得する' do
        expect(Experience.created_at_sorted).to eq [experience3, experience2, experience1]
      end
    end
  end
end