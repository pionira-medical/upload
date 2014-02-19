require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  fixtures :all

  def setup
    @order_params = {
      description: 'Lorem Ipsum',
      admin_user_id: admin_users(:admin).id,
      user_attributes: {
        gender: 1,
        academic_title: nil,
        first_name: 'Max',
        last_name: 'Mustermann',
        email: 'gw@example.org',
        password: 'gw@example.org'
    }}

    @addresses = [{
      title: 'Billig Address',
      gender: 1,
      academic_title: nil,
      first_name: 'Lars',
      last_name: 'Mustermann',
      email: 'lm@example.org',
      street_1: 'Musterstr. 1',
      zip: '12345',
      city: 'Musterstadt'
    }, {
      title: 'Shipping Address',
      gender: 1,
      academic_title: nil,
      first_name: 'Hans',
      last_name: 'Mustermann',
      email: 'hm@example.org',
      street_1: 'Musterstr. 2',
      zip: '12345',
      city: 'Musterstadt'
    }]
  end

  def test_create_order_with_user_and_address
    order_params = @order_params
    order_params[:addresses_attributes] = @addresses
    order = Order.create!(@order_params)
    user = User.find_by_order_id(order.id)
    addresses = Address.where(order_id: order.id)
    
    assert_equal user.id, order.order_number
    assert order.addresses.size > 0
    assert_equal order_params[:addresses_attributes].size, order.addresses.size
  end
  
  def test_create_order_with_addresses
    order_params = @order_params
    order_params[:addresses_attributes] = @addresses
    assert order = Order.create!(@order_params)
    assert !@order_params[:addresses_attributes].empty?
    assert_equal @order_params[:addresses_attributes].size, order.addresses.size
  end

  def test_update_order
    order = Order.create(@order_params)
    order.user.first_name = 'Lars' and order.save
    assert_equal User.find(order.order_number).first_name, order.user.first_name
  end

  def test_destroy_order_with_associations
    order_params = @order_params
    order_params[:addresses_attributes] = @addresses
    order = Order.create(order_params)
    order_id = order.id

    assert order.destroy
    assert_not_nil AdminUser.find(admin_users(:admin).id)
    assert_nil User.find_by_order_id(order_id)
    assert_nil Address.find_by_order_id(order_id)
  end

  def test_validation
    # missing admin_user
    missing_admin_user_params = @order_params.merge(admin_user_id: nil)
    assert Order.new(missing_admin_user_params).invalid?

    # missing zip code for address
    order_params = @order_params
    order_params[:addresses_attributes] = @addresses
    order_params[:addresses_attributes].first[:zip] = nil
    assert Order.new(order_params).invalid?
  end
end
