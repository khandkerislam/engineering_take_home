FactoryBot.define do
    factory :building_custom_value do
      value { "Sample Value" }

      transient do
        client { create(:client) }
      end


      building { association :building, client: client }
      custom_field { association :custom_field, client: client }

      trait :number_value do
        value { "123" }
        custom_field { association :custom_field, :number_type, client: client }
      end

      trait :string_value do
        value { "Some string" }
        custom_field { association :custom_field, client: client }
      end

      trait :list_value do
        value { "Option 1" }
        custom_field { association :custom_field, :list_type, client: client }
      end
    end
  end
