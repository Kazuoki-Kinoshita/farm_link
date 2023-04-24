require 'rails_helper'

RSpec.describe General, type: :model do
  describe 'バリデーションテスト' do
    let(:general) { FactoryBot.build(:general) }

    context 'Generalの名前が空の場合' do
      it 'バリデーションに引っかかる' do
        general.name = ''
        expect(general).not_to be_valid
      end
    end

    context 'Generalの名前が256文字以上の場合' do
      it 'バリデーションに引っかかる' do
        general.name = 'a' * 256
        expect(general).not_to be_valid
      end
    end

    context 'Generalの名前が255文字以内の場合' do
      it 'バリデーションが通る' do
        general.name = 'a' * 255
        expect(general).to be_valid
      end
    end

    context 'Generalの都道府県IDが空の場合' do
      it 'バリデーションに引っかかる' do
        general.prefecture_id = nil
        expect(general).not_to be_valid
      end
    end

    context 'Generalの住所が空の場合' do
      it 'バリデーションに引っかかる' do
        general.address = ''
        expect(general).not_to be_valid
      end
    end

    context 'Generalの住所が256文字以上の場合' do
      it 'バリデーションに引っかかる' do
        general.address = 'a' * 256
        expect(general).not_to be_valid
      end
    end

    context 'Generalの住所が255文字以内の場合' do
      it 'バリデーションが通る' do
        general.address = 'a' * 255
        expect(general).to be_valid
      end
    end

    context '全ての項目が正しく入力されている場合' do
      it 'バリデーションが通る' do
        expect(general).to be_valid
      end
    end
  end
end