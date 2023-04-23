class Farmer < ApplicationRecord
  attr_accessor :skip_plot_validation
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
  belongs_to :user
  has_one_attached :image
  has_many :posts, dependent: :destroy
  has_many :experiences, dependent: :destroy
  has_many :plots, dependent: :destroy
  accepts_nested_attributes_for :plots, allow_destroy: true, reject_if: :all_blank
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  validates :name, presence: true, length: { maximum: 100 }
  validates :prefecture_id, presence: true
  validates :address, presence: true, length: { maximum: 255 }
  validates :station, presence: true, length: { maximum: 255 }
  validates :product, presence: true, length: { maximum: 255 }
  validates :website, length: { maximum: 255 }, format: { with: /\Ahttps?:\/\/[\S]+\z/, allow_blank: true }
  validate :validate_plot_presence

  scope :created_at_sorted, -> { order(created_at: :desc) }

  private
  
  def self.ransackable_attributes(auth_object = nil)
    ["address", "name", "product", "profile", "prefecture_id", "station"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["user"]
  end

  def validate_plot_presence
    return if skip_plot_validation
    valid_plots = plots.reject(&:marked_for_destruction?) # 削除される予定のプロットを除外し、残りのプロットを代入
    if valid_plots.empty? || valid_plots.all? { |plot| plot.name.blank? }
      errors.add(:base, "農地カテゴリを入力してください")
    end
  end
end