class CreateExperiences < ActiveRecord::Migration[6.1]
  def change
    create_table :experiences do |t|
      t.references :farmer, null: false, foreign_key: true
      t.string :title, null: false
      t.text :content, null: false
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
