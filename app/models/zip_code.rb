class ZipCode < ApplicationRecord
  belongs_to :state
  has_many :buildings
end
