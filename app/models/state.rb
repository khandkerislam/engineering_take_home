class State < ApplicationRecord
    include States

    has_many :zip_codes
    has_many :buildings, through: :zip_codes

    validates :name, presence: true, uniqueness: true, inclusion: { in: States::NAMES }
    validates :code, presence: true, length: { is: 2 }, uniqueness: true, inclusion: { in: States::CODES }
end
