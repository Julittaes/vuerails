class Property < ApplicationRecord
  # belongs_to :account
  has_one :rating
  geocoded_by :address
  after_validation :geocode
  has_one_attached :avatar
end
