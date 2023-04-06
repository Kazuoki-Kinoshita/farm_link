class CreateGenerals < ActiveRecord::Migration[6.1]
  def change
    create_table :generals do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :prefecture_id, null: false
      t.string :address, null: false
      t.string :image

      t.timestamps
    end
  end
end
