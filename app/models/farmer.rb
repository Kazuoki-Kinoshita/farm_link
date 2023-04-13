class Farmer < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
  belongs_to :user
  has_one_attached :image
  has_many :posts, dependent: :destroy
  has_many :experiences, dependent: :destroy
  has_many :plots, dependent: :destroy
  accepts_nested_attributes_for :plots, allow_destroy: true, reject_if: :all_blank

  validates :name, presence: true, length: { maximum: 100 }
  validates :prefecture_id, presence: true
  validates :address, presence: true, length: { maximum: 255 }
  validates :phone_number, presence: true, format: { with: /\A\d{10,11}\z/, allow_blank: true }
  validates :product, presence: true, length: { maximum: 100 }
  validates :website, length: { maximum: 255 }, format: { with: /\Ahttps?:\/\/[\S]+\z/, allow_blank: true }
  validates :profile, length: { maximum: 2000 }
  validate :validate_plot_presence

  private
  
  def self.ransackable_attributes(auth_object = nil)
    ["address", "name", "product", "profile", "prefecture_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["user"]
  end

  def validate_plot_presence
    valid_plots = plots.reject(&:marked_for_destruction?)
    if valid_plots.empty?
      errors.add(:base, :empty)
    end
  end
end