require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:farmer) { FactoryBot.create(:farmer) }
  let(:post) { FactoryBot.build(:post, farmer: farmer) }

  describe 'アソシエーションテスト' do
    it 'Farmerモデルと関連付けされている' do
      expect(Post.reflect_on_association(:farmer).macro).to eq :belongs_to
    end
  end

  describe 'バリデーションテスト' do
    context 'titleが空の場合' do
      it 'バリデーションに引っかかる' do
        post.title = ''
        expect(post).not_to be_valid
      end
    end

    context 'titleが256文字以上の場合' do
      it 'バリデーションに引っかかる' do
        post.title = 'a' * 256
        expect(post).not_to be_valid
      end
    end

    context 'titleが255文字以内の場合' do
      it 'バリデーションが通る' do
        post.title = 'a' * 255
        expect(post).to be_valid
      end
    end

    context 'imagesが5枚以上添付されている場合' do
      it 'バリデーションに引っかかる' do
        5.times do |i|
          file_path = Rails.root.join('spec', 'fixtures', 'example.jpg')
          post.images.attach(io: File.open(file_path), filename: "example_#{i}.jpg", content_type: 'image/jpeg')
        end
        expect(post).not_to be_valid
      end
    end

    context 'imagesが4枚以内添付されている場合' do
      it 'バリデーションが通る' do
        4.times do |i|
          file_path = Rails.root.join('spec', 'fixtures', 'example.jpg')
          post.images.attach(io: File.open(file_path), filename: "example_#{i}.jpg", content_type: 'image/jpeg')
        end
        expect(post).to be_valid
      end
    end
  end

  describe 'scopes' do
    let!(:post1) { FactoryBot.create(:post, farmer: farmer, created_at: 2.days.ago) }
    let!(:post2) { FactoryBot.create(:post, farmer: farmer, created_at: 1.day.ago) }
    let!(:post3) { FactoryBot.create(:post, farmer: farmer, created_at: Time.now) }

    describe '.created_at_sorted' do
      it 'created_atの降順でPostsを取得する' do
        expect(Post.created_at_sorted).to eq [post3, post2, post1]
      end
    end
  end
end