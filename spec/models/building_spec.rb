require 'rails_helper'

RSpec.describe Building, type: :model do
  describe 'associations' do
    it { should belong_to(:client) }
  end

  describe 'validations' do
    it { should validate_presence_of(:address) }
  end
end
