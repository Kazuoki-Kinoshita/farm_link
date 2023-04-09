class Farmer < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
  belongs_to :user

  validates :name, presence: true, length: { maximum: 100 }
  validates :prefecture_id, presence: true
  validates :address, presence: true, length: { maximum: 255 }
  validates :phone_number, presence: true, format: { with: /\A\d{10,11}\z/ }
  validates :product, presence: true, length: { maximum: 100 }
  validates :website, length: { maximum: 255 }, format: { with: /\Ahttps?:\/\/[\S]+\z/, allow_blank: true }
  validates :profile, length: { maximum: 2000 }
end
