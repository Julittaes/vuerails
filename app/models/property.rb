class Property < ApplicationRecord
  belongs_to :account
  has_one :location
  has_one :rating
end
