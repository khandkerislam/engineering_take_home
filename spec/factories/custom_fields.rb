FactoryBot.define do
  factory :custom_field do
    name { 'Custom Field' }
    field_type { :number }
    client
    
    trait :list_type do
      field_type { :list }
      enum_options { ["Option 1", "Option 2"] }
    end

    trait :string_type do
      field_type { :string }
    end
  end
end
