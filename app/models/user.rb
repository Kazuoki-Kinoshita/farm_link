class User < ApplicationRecord
  enum role: { farmer: 0, general: 1, admin: 2 }
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
