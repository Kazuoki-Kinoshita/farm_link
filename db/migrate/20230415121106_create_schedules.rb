class CreateSchedules < ActiveRecord::Migration[6.1]
  def change
    create_table :schedules do |t|
      t.references :experience, null: false, foreign_key: true
      t.string :title, null: false
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
