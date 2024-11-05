require 'rails_helper'

RSpec.describe BuildingCustomValue, type: :model do
  describe 'value_matches_field_type validation' do
    let(:client) { create(:client) }

    context 'when field_type is number' do
      subject { build(:building_custom_value, :number_value) }

      it 'is valid with numeric string' do
        subject.value = "123.45"
        expect(subject).to be_valid
      end

      it 'is valid with integer string' do
        subject.value = "123"
        expect(subject).to be_valid
      end

      it 'is invalid with non-numeric string' do
        subject.value = "abc"
        expect(subject).not_to be_valid
        expect(subject.errors[:value]).to include('must be a number')
      end

      it 'is invalid with special characters' do
        subject.value = "$123"
        expect(subject).not_to be_valid
        expect(subject.errors[:value]).to include('must be a number')
      end
    end

    context 'when field_type is string' do
      subject { build(:building_custom_value, :string_value) }

      it 'is valid with string value' do
        subject.value = "test string"
        expect(subject).to be_valid
      end

      it 'is valid with converted non-string value' do
        subject.value = 123
        expect(subject).to be_valid
      end
    end

    context 'when field_type is list' do
      let(:enum_options) { ["Option 1", "Option 2", "Option 3"] }
      subject { 
        build(:building_custom_value, :list_value, 
          custom_field: create(:custom_field, :list_type, enum_options: enum_options)
        )
      }

      it 'is valid with any option from the list' do
        enum_options.each do |option|
          subject.value = option
          expect(subject).to be_valid
        end
      end

      it 'is invalid with value not in enum_options' do
        subject.value = "Invalid Option"
        expect(subject).not_to be_valid
        expect(subject.errors[:value]).to include('must be a valid option')
      end

      it 'is invalid with empty string' do
        subject.value = ""
        expect(subject).not_to be_valid
      end
    end
  end
end
