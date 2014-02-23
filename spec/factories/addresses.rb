require 'faker'

FactoryGirl.define do
  factory :address do
  	title Faker::Lorem.word
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    street_1 Faker::Address.street_name
    street_2 Faker::Address.secondary_address
    zip Faker::Address.zip_code
    city Faker::Address.city
    email Faker::Internet.email
    order
  end
end