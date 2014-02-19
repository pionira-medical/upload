class Address < ActiveRecord::Base
  belongs_to :order

  validates :street_1, :zip, :city, presence: true
  validates :zip, numericality: true
end
