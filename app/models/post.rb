class Post < ApplicationRecord
  belongs_to :farmer
  has_many_attached :images

  validates :title, presence: true, length: { maximum: 255 }
  validate :validate_images

  scope :created_at_sorted, -> { order(created_at: :desc) }

  def validate_images
    if images.attached? && images.length > 4
      errors.add(:images, 'は最大4枚までアップロードできます。')
    end
  end
end