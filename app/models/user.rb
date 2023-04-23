class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  enum role: { farmer: 0, general: 1, admin: 2 }
  
  has_one :general, dependent: :destroy
  has_one :farmer, dependent: :destroy

  has_many :active_relationships, foreign_key: 'follower_id', class_name: 'Relationship', dependent: :destroy
  has_many :passive_relationships, foreign_key: 'followed_id', class_name: 'Relationship', dependent: :destroy 
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :messages, dependent: :destroy
  has_many :sent_conversations, foreign_key: :sender_id, class_name: 'Conversation', dependent: :destroy
  has_many :received_conversations, foreign_key: :recipient_id, class_name: 'Conversation', dependent: :destroy

  validates :name, presence: true, length: { maximum: 255 }
  validates :role, presence: { message: "「農家の方」または「一般の方」を選択してください" }

  def follow!(other_user)
    active_relationships.create!(followed_id: other_user.id)
  end

  def following?(other_user)
    active_relationships.find_by(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def self.guest_admin
    find_or_create_by!(email: 'guest_admin@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲストユーザー(管理者)"
      user.role = :admin
    end
  end

  def self.guest_farmer_nil
    find_or_create_by!(email: 'guest_farmer_nil@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲストユーザー(農家/プロフィール登録なし)"
      user.role = :farmer
    end
  end

  def self.guest_farmer_present
    find_or_create_by!(email: 'guest_farmer_nil@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲストユーザー(農家/プロフィール登録あり)"
      user.role = :farmer
    end.tap do |user|
      farmer = user.farmer || user.build_farmer(
        name: 'ゲスト農家',
        prefecture_id: 13,
        address: '東京都中央区ゲスト市123-4',
        station: 'ゲスト駅',
        product: 'ゲスト作物',
        skip_plot_validation: true
      )

      if farmer.new_record?
        farmer.save!
      end

      if farmer.plots.empty?
        farmer.plots.create!(
          name: 'ゲスト農地'
        )
      end
    end
  end

  def self.guest_general_nil
    find_or_create_by!(email: 'guest_general_nil@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲストユーザー(一般の方/プロフィール登録なし)"
      user.role = :general
    end
  end

  def self.guest_general_present
    find_or_create_by!(email: 'guest_general_present@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲストユーザー(一般の方/プロフィール登録あり)"
      user.role = :general
    end.tap do |user|
      user.create_general!(
        name: 'ゲストユーザー（一般の方）',
        prefecture_id: 1,
        address: 'ゲスト県ゲスト市567-8',
        favorite_crop: 'ゲスト野菜'
      ) unless user.general.present?
    end
  end
end