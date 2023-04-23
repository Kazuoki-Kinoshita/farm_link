class ChangeScheduleColumns < ActiveRecord::Migration[6.1]
  def change
    change_column_null :schedules, :title, true
    change_column_null :schedules, :start_time, false
    change_column_null :schedules, :end_time, false
  end
end
