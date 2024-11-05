FactoryBot.define do
  factory :zip_code do
    code { 22312 }
    city { 'Alexandria' }
    association :state
  end
end
