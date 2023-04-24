require 'rails_helper'

RSpec.describe Farmer, type: :model do
  let(:user) { FactoryBot.create(:user2) }
  let(:farmer) { FactoryBot.build(:farmer, user: user) }

  let(:user2) { FactoryBot.create(:user2) }
  let(:farmer) { FactoryBot.create(:farmer, user: user2) }

  describe 'バリデーションテスト' do
    let(:farmer) { FactoryBot.build(:farmer) }

    context 'Farmerの名前が空の場合' do
      it 'バリデーションに引っかかる' do
        farmer.name = ''
        expect(farmer).not_to be_valid
      end
    end

    context 'Farmerの名前が101文字以上の場合' do
      it 'バリデーションに引っかかる' do
        farmer.name = 'a' * 101
        expect(farmer).not_to be_valid
      end
    end

    context 'Farmerの名前が100文字以内の場合' do
      it 'バリデーションが通る' do
        farmer.name = 'a' * 100
        expect(farmer).to be_valid
      end
    end

    context 'Farmerの都道府県IDが空の場合' do
      it 'バリデーションに引っかかる' do
        farmer.prefecture_id = nil
        expect(farmer).not_to be_valid
      end
    end

    context 'Farmerの住所が空の場合' do
      it 'バリデーションに引っかかる' do
        farmer.address = ''
        expect(farmer).not_to be_valid
      end
    end

    context 'Farmerの住所が256文字以上の場合' do
      it 'バリデーションに引っかかる' do
        farmer.address = 'a' * 256
        expect(farmer).not_to be_valid
      end
    end

    context 'Farmerの住所が255文字以内の場合' do
      it 'バリデーションが通る' do
        farmer.address = 'a' * 255
        expect(farmer).to be_valid
      end
    end

    context 'Farmerの駅名が空の場合' do
      it 'バリデーションに引っかかる' do
        farmer.station = ''
        expect(farmer).not_to be_valid
      end
    end

    context 'Farmerの駅名が256文字以上の場合' do
      it 'バリデーションに引っかかる' do
        farmer.station = 'a' * 256
        expect(farmer).not_to be_valid
      end
    end

    context 'Farmerの駅名が255文字以内の場合' do
      it 'バリデーションが通る' do
        farmer.station = 'a' * 255
        expect(farmer).to be_valid
      end
    end

    context 'Farmerの農作物が空の場合' do
      it 'バリデーションに引っかかる' do
        farmer.product = ''
        expect(farmer).not_to be_valid
      end
    end

    context 'Farmerの農作物が256文字以上の場合' do
      it 'バリデーションに引っかかる' do
        farmer.product = 'a' * 256
        expect(farmer).not_to be_valid
      end
    end

    context 'Farmerの農作物が255文字以内の場合' do
      it 'バリデーションが通る' do
        farmer.product = 'a' * 255
        expect(farmer).to be_valid
      end
    end

    context 'Farmerのウェブサイトが正しい形式で入力されている場合' do
      it 'バリデーションが通る' do
        farmer.website = 'https://example.com'
        expect(farmer).to be_valid
      end
    end

    context 'Farmerのウェブサイトが正しくない形式で入力されている場合' do
      it 'バリデーションに引っかかる' do
        farmer.website = 'example.com'
        expect(farmer).not_to be_valid
      end
    end

    context 'Farmerに関連付けられたPlotがない場合' do
      it 'バリデーションに引っかかる' do
        farmer.plots = []
        expect(farmer).not_to be_valid
        expect(farmer.errors[:base]).to include("農地カテゴリを入力してください")
      end
    end

    context '全ての項目が正しく入力されている場合' do
      it 'バリデーションが通る' do
        expect(farmer).to be_valid
      end
    end
  end

  describe 'scopes' do
    let!(:farmer1) { FactoryBot.create(:farmer, user: user, created_at: 2.days.ago) }
    let!(:farmer2) { FactoryBot.create(:farmer, user: user, created_at: 1.day.ago) }
    let!(:farmer3) { FactoryBot.create(:farmer, user: user, created_at: Time.now) }

    describe '.created_at_sorted' do
      it 'created_atの降順でFarmersを取得する' do
        expect(Farmer.created_at_sorted).to eq [farmer3, farmer2, farmer1]
      end
    end
  end
end