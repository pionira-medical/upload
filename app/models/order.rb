class Order < ActiveRecord::Base
  belongs_to :admin_user
  has_one :user, autosave: true
  has_many :addresses, inverse_of: :order
  accepts_nested_attributes_for :addresses, allow_destroy: true
  accepts_nested_attributes_for :user

  before_validation :autocomplete_empty_fields
  
  validates :admin_user, :user, presence: true
  validates :order_number, uniqueness: true, numericality: true, length: { is: 5 }
  validates :security_key, numericality: true, length: { is: 5 }

  private

  def autocomplete_empty_fields
    self.order_number = rand(11111..99999)
    self.security_key = rand(11111..99999)
    user.id = self.order_number
    user.password = self.security_key
  end
end
