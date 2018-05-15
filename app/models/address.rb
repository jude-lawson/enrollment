class Address < ApplicationRecord
  validates_presence_of :description, :street_address, :city, :state, :zip_code
  belongs_to :student
end
