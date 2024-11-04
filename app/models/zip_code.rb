class ZipCode < ApplicationRecord
  belongs_to :state
  has_many :buildings

  validates :code, presence: true, uniqueness: true
  validates :city, presence: true
end
