FactoryBot.define do
  factory :building do
    address { "123 Beauregard St" }
    association :client
    association :zip_code
  end
end
