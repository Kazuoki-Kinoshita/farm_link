class General < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
  belongs_to :user

  validates :prefecture_id, presence: true
  validates :address, presence: true, length: { maximum: 255 }
end
