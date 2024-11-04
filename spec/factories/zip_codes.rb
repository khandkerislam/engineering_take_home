FactoryBot.define do
  factory :zip_code do
    code { 22312 }
    state { create(:state) }
    city { 'Alexandria' }
  end
end
