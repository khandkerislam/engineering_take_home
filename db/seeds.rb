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
ny_state = State.find_or_create_by!(name: 'New York', code: 'NY')
ny_zip_code = ZipCode.find_or_create_by!(code: 10001, state: ny_state, city: 'New York')
ca_state = State.find_or_create_by!(name: 'California', code: 'CA')
ca_zip_code = ZipCode.find_or_create_by!(code: 90001, state: ca_state, city: 'Los Angeles')

clients = [
  Client.new(name: 'Larchmont Properties'), 
  Client.new(name: 'Skyline Realty'), 
  Client.new(name: 'Landmark Development')
]
buildings = [
  *(20.times.map { |i| Building.new(address: "#{100 + i} Madison Ave", zip_code: ny_zip_code, client: clients[0]) }),
  *(20.times.map { |i| Building.new(address: "#{100 + i} Beauregard St", zip_code: va_zip_code, client: clients[1]) }),
  *(20.times.map { |i| Building.new(address: "#{100 + i} Hollywood Blvd", zip_code: ca_zip_code, client: clients[2]) }),
]

custom_fields = [
  CustomField.new(name: 'Number of Floors', field_type: :number, client: clients[0]), 
  CustomField.new(name: 'Number of Units', field_type: :number, client: clients[0]),
  CustomField.new(name: 'Building Type', field_type: :list, enum_options: ['Residential', 'Commercial', 'Mixed Use'], client: clients[1]),
  CustomField.new(name: 'Year Built', field_type: :number, client: clients[2]),
  CustomField.new(name: 'Historical Notes', field_type: :string, client: clients[2])
]
building_custom_values = [
  # For NY buildings (clients[0]) - Number of Floors and Units
  *(20.times.flat_map do |i|
    [
      BuildingCustomValue.new(building: buildings[i], custom_field: custom_fields[0], value: rand(3..10)),
      BuildingCustomValue.new(building: buildings[i], custom_field: custom_fields[1], value: rand(10..50))
    ]
  end),

  # For VA buildings (clients[1]) - Building Type
  *(20.times.map do |i|
    BuildingCustomValue.new(
      building: buildings[i + 20], 
      custom_field: custom_fields[2], 
      value: ['Residential', 'Commercial', 'Mixed Use'].sample
    )
  end),

  # For CA buildings (clients[2]) - Year Built and Historical Notes
  *(20.times.flat_map do |i|
    [
      BuildingCustomValue.new(building: buildings[i + 40], custom_field: custom_fields[3], value: rand(1920..2000)),
      BuildingCustomValue.new(
        building: buildings[i + 40], 
        custom_field: custom_fields[4], 
        value: ["Former bank building", "Historic landmark", "Renovated in 2010", "Original facade"].sample
      )
    ]
  end)
]

Rails.logger.info "Creating clients, buildings and custom fields..."
ActiveRecord::Base.transaction do
  clients.each(&:save!)
  buildings.each(&:save!)
  custom_fields.each(&:save!)
  building_custom_values.each(&:save!)
end

Rails.logger.info "Seed data created successfully!"
