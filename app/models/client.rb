class Client < ApplicationRecord
    validates :name, presence: true
    has_many :buildings, dependent: :destroy
    has_many :custom_fields, dependent: :destroy
end