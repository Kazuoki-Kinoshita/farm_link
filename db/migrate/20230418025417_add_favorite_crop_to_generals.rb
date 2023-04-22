class AddFavoriteCropToGenerals < ActiveRecord::Migration[6.1]
  def change
    add_column :generals, :favorite_crop, :string
  end
end
