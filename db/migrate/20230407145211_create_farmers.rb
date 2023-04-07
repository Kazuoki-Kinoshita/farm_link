class CreateFarmers < ActiveRecord::Migration[6.1]
  def change
    create_table :farmers do |t|
      t.references :user, null: false, foreign_key: true
      t.string  :name, null: false
      t.integer :prefecture_id, null: false
      t.string  :address, null: false
      t.float   :latitude
      t.float   :longitude
      t.string  :phone_number, null: false
      t.string  :product
      t.string  :website
      t.string  :image
      t.text    :profile

      t.timestamps
    end
  end
end
