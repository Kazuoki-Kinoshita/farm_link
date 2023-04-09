class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  enum role: { farmer: 0, general: 1, admin: 2 }
  
  has_one :general, dependent: :destroy
  has_one :farmer, dependent: :destroy

  validates :name, presence: true, length: { maximum: 255 }
  validates :role, presence: true
end