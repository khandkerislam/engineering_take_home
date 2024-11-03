class AddClientRefToBuildings < ActiveRecord::Migration[7.2]
  def change
    add_reference :buildings, :client, null: false, foreign_key: true
  end
end
