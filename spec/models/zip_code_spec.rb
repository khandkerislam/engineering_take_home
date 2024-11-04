require 'rails_helper'

RSpec.describe ZipCode, type: :model do
  describe 'associations' do
    it { should belong_to(:state) }
  end

  describe 'validations' do
    subject { build(:zip_code) }
    it { should validate_presence_of(:code) }
    it { should validate_uniqueness_of(:code) }
    it { should validate_presence_of(:city) }
  end
end
