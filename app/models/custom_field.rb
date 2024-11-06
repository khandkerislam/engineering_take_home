class CustomField < ApplicationRecord
    belongs_to :client

    enum :field_type, %i[number string list], validate: true
    validates :name, presence: true
    validate :validate_enum_options, if: :list?

    private

    def validate_enum_options
        if enum_options.blank?
          errors.add(:enum_options, "can't be blank for enum fields")
        elsif !enum_options.is_a?(Array)
          errors.add(:enum_options, "must be an array")
        elsif !enum_options.all?(String)
          errors.add(:enum_options, "must all be strings")
        end
    end
end
