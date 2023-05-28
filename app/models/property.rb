class Property < ApplicationRecord
  belongs_to :account
  has_many :locations
  has_one :rating
end
