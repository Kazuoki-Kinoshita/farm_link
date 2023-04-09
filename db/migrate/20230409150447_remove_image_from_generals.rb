class RemoveImageFromGenerals < ActiveRecord::Migration[6.1]
  def change
    remove_column :generals, :image, :string
  end
end
