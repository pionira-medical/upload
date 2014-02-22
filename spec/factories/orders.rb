require 'faker'

FactoryGirl.define do
  factory :order do |f|
  	description { Faker::Lorem.paragraph }
  	user
  	admin_user

  	factory :order_with_addresses do
      ignore do
        addresses_count 2
      end

      after(:create) do |order, evaluator|
        create_list(:address, evaluator.addresses_count, order: order)
      end
    end
  end
end