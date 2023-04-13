class CreatePlots < ActiveRecord::Migration[6.1]
  def change
    create_table :plots do |t|
      t.references :farmer, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
