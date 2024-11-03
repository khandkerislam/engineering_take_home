class CreateZipCodes < ActiveRecord::Migration[7.2]
  def change
    create_table :zip_codes do |t|
      t.string :code
      t.string :city
      t.references :state, null: false, foreign_key: true

      t.timestamps
    end
    add_index :zip_codes, :code, unique: true
  end
end
