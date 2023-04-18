class AddStationAndRemovePhoneNumberFromFarmers < ActiveRecord::Migration[6.1]
  def change
    add_column :farmers, :station, :string, null: false
    remove_column :farmers, :phone_number, :string
  end
end
