class Order < ActiveRecord::Base
  belongs_to :admin_user
  has_one :user
  has_many :addresses
  accepts_nested_attributes_for :addresses, allow_destroy: true
  accepts_nested_attributes_for :user

  before_validation :complete_user

  private
  def complete_user
    user.id = order_number
    user.password = security_key
  end
end
