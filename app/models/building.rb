class Building < ApplicationRecord
    belongs_to :client
    belongs_to :zip_code

    has_many :building_custom_values, dependent: :destroy
    validates :address, presence: true
end
