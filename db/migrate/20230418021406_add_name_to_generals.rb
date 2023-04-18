class AddNameToGenerals < ActiveRecord::Migration[6.1]
  def change
    add_column :generals, :name, :string, default: "generals"
    change_column_null :generals, :name, false
    change_column_default :generals, :name, nil
  end
end
