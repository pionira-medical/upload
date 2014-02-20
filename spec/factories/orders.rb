require 'faker'

FactoryGirl.define do
  factory :order do |f|
  	security_key { rand(11111..99999) }
  	order_number { rand(11111..99999) }
  	description { Faker::Lorem.paragraph }
  	user
  	admin_user
  end
end