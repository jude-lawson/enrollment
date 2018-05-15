class Student < ApplicationRecord
  validates_presence_of :first_name, :last_name
  has_many :addresses
end
