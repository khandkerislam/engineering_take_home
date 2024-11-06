class Building < ApplicationRecord
    belongs_to :client
    belongs_to :zip_code

    has_many :building_custom_values, dependent: :destroy
    validates :address, presence: true

    def full_address
        "#{address}, #{zip_code&.city}, #{zip_code&.state&.code} #{zip_code&.code}"
    end

    def create_custom_values(custom_values)
        return unless custom_values.present?

        client.custom_fields.each do |custom_field|
            next unless custom_values[custom_field.name].present?

            building_custom_values.create!(
                building: self,
                custom_field: custom_field,
                value: custom_values[custom_field.name]
            )
        end
    end
end
