class Plot < ApplicationRecord
  belongs_to :farmer
  has_many :experience_plots, dependent: :destroy
  has_many :experiences, through: :experience_plots
end