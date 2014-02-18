class Order < ActiveRecord::Base
	has_many :addresses
	has_one :user
	accepts_nested_attributes_for :addresses
	accepts_nested_attributes_for :user
end
