class Schedule < ApplicationRecord
  belongs_to :experience

  validates :title, presence: true, length: { maximum: 15 }
  validate :start_time_must_be_before_end_time

  scope :saved, -> { where.not(id: nil) }

  private

  def start_time_must_be_before_end_time
    if start_time.present? && end_time.present? && start_time >= end_time
      errors.add(:start_time, "は終了時間より前でなければなりません")
    end
  end
end
