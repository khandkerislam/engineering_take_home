FactoryBot.define do
  factory :client do
    name { "Default Client" }

    trait :with_buildings do
      after(:build) do |client|
        create_list(:building, 3, client: client)
      end
    end

    trait :with_custom_fields do
      after(:build) do |client|
        create(:custom_field, client: client, name: "Custom Field 1")
        create(:custom_field, client: client, name: "Custom Field 2")
        create(:custom_field, client: client, name: "Custom Field 3")
      end
    end

    trait :with_buildings_and_custom_fields do
      with_buildings
      with_custom_fields
    end

    trait :with_buildings_and_custom_values do
      with_buildings
      with_custom_fields
      after(:build) do |client|
        custom_fields = client.custom_fields
        client.buildings.each do |building|
          custom_fields.each do |custom_field|
            create(:building_custom_value, building: building, custom_field: custom_field, value: Faker::Lorem.word)
          end
        end
      end
    end
  end
end
