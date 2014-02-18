class Order < ActiveRecord::Base
  has_many :addresses
  has_one :user
  belongs_to :admin_user
  accepts_nested_attributes_for :addresses
  accepts_nested_attributes_for :user

  before_create :complete_user

  private
  def complete_user
    self.user.id = self.order_number
    self.user.password = self.security_key
  end
end
