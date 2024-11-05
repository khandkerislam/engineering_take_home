FactoryBot.define do
  factory :zip_code do
    code { 22312 }
    state { State.first || association(:state) }
    city { 'Alexandria' }
  end
end
