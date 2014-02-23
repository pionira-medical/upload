require 'faker'

FactoryGirl.define do
  factory :order do |f|
  	description { Faker::Lorem.paragraph }
  	user
  	admin_user

  	factory :order_with_addresses do
      before(:create) do |order, evaluator|
        order.addresses = create_list(:address, 2, order: order)
      end
    end
  end
end