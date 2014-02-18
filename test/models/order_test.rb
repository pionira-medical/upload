require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  fixtures :all
  def test_create_order
    order_params = {
      description: 'Lorem Ipsum',
      order_number: '12345',
      security_key: '67890',
      user_attributes: {
        gender: 1,
        academic_title: nil,
        first_name: 'Max',
        last_name: 'Mustermann',
        email: 'gw@example.org',
        password: 'gw@example.org'
    }}
    assert order = Order.create(order_params)
    assert_not_nil order.user
    assert_equal User.find(order.order_number), order.user
  end
end
