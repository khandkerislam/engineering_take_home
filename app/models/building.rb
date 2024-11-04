class Building < ApplicationRecord
    belongs_to :client
    belongs_to :zip_code
    validates :address, presence: true
end
