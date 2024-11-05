# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Rails.logger.info "Clearing existing data..."
[Client, Building, CustomField, BuildingCustomValue].each(&:destroy_all)

Rails.logger.info "Creating location data..."
va_state = State.find_or_create_by!(name: 'Virginia', code: 'VA')
va_zip_code = ZipCode.find_or_create_by!(code: 22312, state: va_state, city: 'Alexandria')

clients = [
  Client.new(name: 'Larchmont Properties'), 
  Client.new(name: 'Skyline Realty'), 
  Client.new(name: 'Landmark Development')
]
buildings = [
  Building.new(address: '123 Beauregard St', zip_code: va_zip_code, client: clients[0]), 
  Building.new(address: '456 Duke St', zip_code: va_zip_code, client: clients[0]),
  Building.new(address: '789 Seminary Rd', zip_code: va_zip_code, client: clients[1]),
  Building.new(address: '321 King St', zip_code: va_zip_code, client: clients[1]),
  Building.new(address: '555 Little River Tpke', zip_code: va_zip_code, client: clients[2])
]
custom_fields = [
  CustomField.new(name: 'Number of Floors', field_type: :number, client: clients[0]), 
  CustomField.new(name: 'Number of Units', field_type: :number, client: clients[0]),
  CustomField.new(name: 'Building Type', field_type: :list, enum_options: ['Residential', 'Commercial', 'Mixed Use'], client: clients[1]),
  CustomField.new(name: 'Year Built', field_type: :number, client: clients[2]),
  CustomField.new(name: 'Historical Notes', field_type: :string, client: clients[2])
]
building_custom_values = [
  BuildingCustomValue.new(building: buildings[0], custom_field: custom_fields[0], value: 3),
  BuildingCustomValue.new(building: buildings[0], custom_field: custom_fields[1], value: 10),
  BuildingCustomValue.new(building: buildings[1], custom_field: custom_fields[0], value: 4),
  BuildingCustomValue.new(building: buildings[1], custom_field: custom_fields[1], value: 12),
  BuildingCustomValue.new(building: buildings[2], custom_field: custom_fields[2], value: 'Residential'),
  BuildingCustomValue.new(building: buildings[3], custom_field: custom_fields[2], value: 'Commercial'),
  BuildingCustomValue.new(building: buildings[4], custom_field: custom_fields[3], value: 1950),
  BuildingCustomValue.new(building: buildings[4], custom_field: custom_fields[4], value: 'Former bank building')
]

Rails.logger.info "Creating clients, buildings and custom fields..."
ActiveRecord::Base.transaction do
  clients.each(&:save!)
  buildings.each(&:save!)
  custom_fields.each(&:save!)
  building_custom_values.each(&:save!)
end

Rails.logger.info "Seed data created successfully!"
