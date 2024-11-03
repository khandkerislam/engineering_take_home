require 'rails_helper'

RSpec.describe ZipCode, type: :model do
  describe 'associations' do
    it { should belong_to(:state) }
  end
end
