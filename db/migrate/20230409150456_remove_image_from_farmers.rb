class RemoveImageFromFarmers < ActiveRecord::Migration[6.1]
  def change
    remove_column :farmers, :image, :string
  end
end
