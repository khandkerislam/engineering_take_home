class BuildingCustomValue < ApplicationRecord
  belongs_to :building, required: true
  belongs_to :custom_field, required: true

  validates :value, presence: true

  validate :value_matches_field_type

  private

  def value_matches_field_type
    case custom_field.field_type
    when "number"
      begin
        Float(value)
      rescue ArgumentError, TypeError
        errors.add(:value, "must be a number")
      end
    when "string"
        errors.add(:value, "must be a string") unless value.is_a?(String)
    when "list"
        errors.add(:value, "must be a valid option") unless custom_field.enum_options.include?(value)
    end
  end
end
