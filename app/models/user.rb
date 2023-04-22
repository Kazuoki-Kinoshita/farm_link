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
end