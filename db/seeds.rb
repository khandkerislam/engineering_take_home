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
  Client.new(name: 'Landmark Development'),
  Client.new(name: 'Richmond Properties'),
  Client.new(name: 'Oakland Properties')
]

custom_fields = [
  CustomField.new(name: 'Number of Floors', field_type: :number, client: clients[0]), 
  CustomField.new(name: 'Number of Units', field_type: :number, client: clients[0]),
  CustomField.new(name: 'Building Type', field_type: :list, enum_options: ['Residential', 'Commercial', 'Mixed Use'], client: clients[1]),
  CustomField.new(name: 'Square Footage', field_type: :number, client: clients[1]),
  CustomField.new(name: 'Year Built', field_type: :number, client: clients[2]),
  CustomField.new(name: 'Historical Notes', field_type: :string, client: clients[2]),
  CustomField.new(name: 'Number of Bathrooms', field_type: :number, client: clients[3]),
  CustomField.new(name: 'Number of Bedrooms', field_type: :number, client: clients[3]),
  CustomField.new(name: 'Parking Spaces', field_type: :number, client: clients[4]),
  CustomField.new(name: 'Roof Type', field_type: :list, enum_options: ['Asphalt', 'Tile', 'Slate'], client: clients[4])
]
buildings = []
building_custom_values = []

100.times do |i|
  client_index = i / 20 
  base_field_index = client_index * 2 

  case client_index
  when 0  # Larchmont Properties - New York
    building = Building.new(address: "#{rand(100..999)} Madison Ave", zip_code: ny_zip_code, client: clients[0])
    values = [
      BuildingCustomValue.new(building: building, custom_field: custom_fields[base_field_index], value: rand(3..10)),
      BuildingCustomValue.new(building: building, custom_field: custom_fields[base_field_index + 1], value: rand(10..50))
    ]
  when 1  # Skyline Realty - Virginia
    building = Building.new(address: "#{rand(1000..1999)} Beauregard St", zip_code: va_zip_code, client: clients[1])
    values = [BuildingCustomValue.new(building: building, custom_field: custom_fields[base_field_index], 
      value: ['Residential', 'Commercial', 'Mixed Use'].sample)]
  when 2  # Landmark Development - California
    building = Building.new(address: "#{rand(5000..5999)} Hollywood Blvd", zip_code: ca_zip_code, client: clients[2])
    values = [
      BuildingCustomValue.new(building: building, custom_field: custom_fields[base_field_index], value: rand(1920..2000)),
      BuildingCustomValue.new(building: building, custom_field: custom_fields[base_field_index + 1], 
        value: ["Former bank building", "Historic landmark", "Renovated in 2010", "Original facade"].sample)
    ]
  when 3  # Richmond Properties - California
    building = Building.new(address: "#{rand(200..499)} N 12th St", zip_code: ca_zip_code, client: clients[3])
    values = [
      BuildingCustomValue.new(building: building, custom_field: custom_fields[base_field_index], value: rand(1..5)),
      BuildingCustomValue.new(building: building, custom_field: custom_fields[base_field_index + 1], value: rand(1..5))
    ]
  when 4  # Oakland Properties - New York
    building = Building.new(address: "#{rand(300..699)} E 16th St", zip_code: ny_zip_code, client: clients[4])
    values = [
      BuildingCustomValue.new(building: building, custom_field: custom_fields[base_field_index], value: rand(1..5)),
      BuildingCustomValue.new(building: building, custom_field: custom_fields[base_field_index + 1], 
        value: ['Asphalt', 'Tile', 'Slate'].sample)
    ]
  end

  buildings << building
  building_custom_values.concat(values)
end

Rails.logger.info "Creating clients, buildings and custom fields..."
ActiveRecord::Base.transaction do
  clients.each(&:save!)
  buildings.each(&:save!)
  custom_fields.each(&:save!)
  building_custom_values.each(&:save!)
end

Rails.logger.info "Seed data created successfully!"
