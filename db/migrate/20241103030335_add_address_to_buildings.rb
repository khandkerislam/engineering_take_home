class AddAddressToBuildings < ActiveRecord::Migration[7.2]
  def change
    add_column :buildings, :address, :string, null: false
  end
end
