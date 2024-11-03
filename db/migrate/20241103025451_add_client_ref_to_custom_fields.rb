class AddClientRefToCustomFields < ActiveRecord::Migration[7.2]
  def change
    add_reference :custom_fields, :client, null: false, foreign_key: true
  end
end
