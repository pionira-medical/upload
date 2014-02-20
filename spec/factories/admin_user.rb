require 'faker'

FactoryGirl.define do
  factory :admin_user do
    email Faker::Internet.email
    password 'password'
  end
end