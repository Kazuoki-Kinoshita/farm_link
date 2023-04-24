require 'rails_helper'

RSpec.describe 'Userモデル機能', type: :model do
  describe 'バリデーションテスト' do
    context 'Userの名前が空の場合' do
      it 'バリデーションに引っかかる' do
        user = User.new(name: '', email: 'test@example.com', password: 'password', role: 'farmer')
        expect(user).not_to be_valid
      end
    end

    context 'Userの名前が256文字以上の場合' do
      it 'バリデーションに引っかかる' do
        long_name = 'a' * 256
        user = User.new(name: long_name, email: 'test@example.com', password: 'password', role: 'farmer')
        expect(user).not_to be_valid
      end
    end
    
    context 'Userの名前が255文字以内の場合' do
      it 'バリデーションが通る' do
        valid_name = 'a' * 255
        user = User.new(name: valid_name, email: 'test@example.com', password: 'password', role: 'farmer')
        expect(user).to be_valid
      end
    end

    context 'Userのメールアドレスが空の場合' do
      it 'バリデーションに引っかかる' do
        user = User.new(name: 'Test User', email: '', password: 'password', role: 'farmer')
        expect(user).not_to be_valid
      end
    end

    context 'Userのパスワードが空の場合' do
      it 'バリデーションに引っかかる' do
        user = User.new(name: 'Test User', email: 'test@example.com', password: '', role: 'farmer')
        expect(user).not_to be_valid
      end
    end

    context 'Userのロールが空の場合' do
      it 'バリデーションに引っかかる' do
        user = User.new(name: 'Test User', email: 'test@example.com', password: 'password', role: '')
        expect(user).not_to be_valid
      end
    end
        
    context '全ての項目が入力されている場合' do
      it 'バリデーションが通る' do
        user = User.new(name: 'Test User', email: 'test@example.com', password: 'password', role: 'farmer')
        expect(user).to be_valid
      end
    end
  end
end