require 'rails_helper'

RSpec.describe State, type: :model do
  describe 'associations' do
    it { should have_many(:buildings).through(:zip_codes) }
  end

  describe 'validations' do
    describe 'name' do
      it { should validate_presence_of(:name) }
      it { should validate_uniqueness_of(:name) }
      it { should validate_inclusion_of(:name).in_array(States::NAMES) }
    end

    describe 'code' do
      it { should validate_presence_of(:code) }
      it { should validate_uniqueness_of(:code) }
      it { should validate_inclusion_of(:code).in_array(States::CODES) }
    end
  end
end
