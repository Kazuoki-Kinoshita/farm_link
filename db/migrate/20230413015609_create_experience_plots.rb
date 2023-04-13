class CreateExperiencePlots < ActiveRecord::Migration[6.1]
  def change
    create_table :experience_plots do |t|
      t.references :plot, null: false, foreign_key: true
      t.references :experience, null: false, foreign_key: true
      t.datetime :created_at

    end
  end
end
