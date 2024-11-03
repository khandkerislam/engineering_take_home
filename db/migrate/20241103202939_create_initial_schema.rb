class CreateInitialSchema < ActiveRecord::Migration[7.2]
  def change
    create_table :states do |t|
      t.string :name, null: false
      t.string :code, null: false, limit: 2

      t.timestamps
    end
    add_index :states, :name, unique: true
    add_index :states, :code, unique: true

    create_table :zip_codes do |t|
      t.string :code, null: false
      t.string :city, null: false
      t.references :state, null: false, foreign_key: true

      t.timestamps
    end
    add_index :zip_codes, :code, unique: true

    create_table :clients do |t|
      t.string :name, null: false

      t.timestamps
    end

    create_table :custom_fields do |t|
      t.string :name, null: false
      t.string :value_type, null: false
      t.string :enum_options
      t.references :client, null: false, foreign_key: true

      t.timestamps
    end

    create_table :buildings do |t|
      t.string :address, null: false
      t.references :client, null: false, foreign_key: true
      t.references :zip_code, null: false, foreign_key: true

      t.timestamps
    end

  end
end