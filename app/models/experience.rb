class Experience < ApplicationRecord
  belongs_to :farmer
  has_many :experience_plots, dependent: :destroy
  has_many :plots, through: :experience_plots
  has_many_attached :images

  validates :title, presence: true, length: { maximum: 255 }
  validates :content, presence: true
  validate :validate_images

  def validate_images
    if images.attached? && images.length > 4
      errors.add(:images, 'は最大4枚までアップロードできます。')
    end
  end
end