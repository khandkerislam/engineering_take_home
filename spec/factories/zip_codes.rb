FactoryBot.define do
  factory :zip_code do
    code { 22312 }
    state { create(:state) }
  end
end
