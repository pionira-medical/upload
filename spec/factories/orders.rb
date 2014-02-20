require 'faker'

FactoryGirl.define do
  factory :order do |f|
  	description { Faker::Lorem.paragraph }
  	user
  	admin_user
  end
end