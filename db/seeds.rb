# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Client.destroy_all
Building.destroy_all

va_state = State.find_or_create_by!(name: 'Virginia', code: 'VA')
va_zip_code = ZipCode.find_or_create_by!(code: 22312, state: va_state)

# Create 5 clients
clients = [
  {
    name: 'Acme Properties',
    buildings: [
      { address: '123 Beauregard St', zip_code: va_zip_code },
      { address: '456 Duke St', zip_code: va_zip_code }
    ]
  },
  {
    name: 'Skyline Realty',
    buildings: [
      { address: '789 Seminary Rd', zip_code: va_zip_code },
      { address: '321 King St', zip_code: va_zip_code }
    ]
  },
  {
    name: 'Urban Dwellings',
    buildings: [
      { address: '555 Little River Tpke', zip_code: va_zip_code }
    ]
  }
].map do |client_info|
  client = Client.create!(name: client_info[:name])

  client_info[:buildings].each do |building_info|
    Building.create!(address: building_info[:address], zip_code: building_info[:zip_code], client: client)
  end
end
