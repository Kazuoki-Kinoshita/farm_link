class Experience < ApplicationRecord
  belongs_to :farmer
  has_many :experience_plots, dependent: :destroy
  has_many :schedules, dependent: :destroy
  has_many :plots, through: :experience_plots
  has_many_attached :images

  validates :title, presence: true, length: { maximum: 255 }
  validates :content, presence: true
  validate :validate_images
  validate :must_have_at_least_one_plot

  scope :created_at_sorted, -> { order(created_at: :desc) }

  private

  def validate_images
    if images.attached? && images.length > 4
      errors.add(:images, 'は最大4枚までアップロードできます')
    end
  end

  def must_have_at_least_one_plot
    if plot_ids.empty?
      errors.add(:base, "農地カテゴリを選択してください")
    end
  end
end