class RemoveStartAndEndTimeFromExperiences < ActiveRecord::Migration[6.1]
  def change
    remove_column :experiences, :start_time, :datetime
    remove_column :experiences, :end_time, :datetime
  end
end
