require 'rails_helper'

RSpec.describe CustomField, type: :model do
  describe 'associations' do
    it { should belong_to(:client) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }

    describe 'field_type enum' do
      it 'allows setting valid types' do
        string_field = build(:custom_field)
        number_field = build(:custom_field, :number_type)
        list_field = build(:custom_field, :list_type)

        expect(string_field.string?).to be true
        expect(number_field.number?).to be true
        expect(list_field.list?).to be true
      end
  
      it 'is invalid for invalid types' do
        field = build(:custom_field, field_type: 'invalid')
        expect(field).to be_invalid
        expect(field.errors[:field_type]).to include('is not included in the list')
      end

      context 'enum options validation' do
        subject{ build(:custom_field, :list_type )}
        
        it 'is invalid without blank enum_options' do
          subject.enum_options = nil
          expect(subject).to be_invalid
          expect(subject.errors[:enum_options]).to include("can't be blank for enum fields")
        end
      end
    end

    describe 'enum_options validation' do
      context 'when field_type is enum' do
        subject { build(:custom_field, :list_type) }

        it 'has correct field_type' do
          expect(subject.list?).to be true
        end

        it 'is invalid without enum_options' do
          subject.enum_options = nil
          expect(subject).to be_invalid
          expect(subject.errors[:enum_options]).to include("can't be blank for enum fields")
        end

        it 'is invalid with empty array' do
          subject.enum_options = []
          expect(subject).to be_invalid
          expect(subject.errors[:enum_options]).to include("can't be blank for enum fields")
        end

        it 'is invalid with non-array' do
          subject.enum_options = "not an array"
          subject.valid?
          expect(subject).to be_invalid
          expect(subject.errors[:enum_options]).to include("must be an array")
        end

        it 'is invalid with non-string elements' do
          subject.enum_options = ['Valid', 123, true]
          expect(subject).to be_invalid
          expect(subject.errors[:enum_options]).to include("must all be strings")
        end

        it 'is valid with array of strings' do
          subject.enum_options = ['Option 1', 'Option 2']
          subject.valid?
          expect(subject).to be_valid
        end
      end
    end
  end
end
