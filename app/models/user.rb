class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  enum role: { farmer: 0, general: 1, admin: 2 }
  
  has_one :general, dependent: :destroy
  has_one :farmer, dependent: :destroy
end