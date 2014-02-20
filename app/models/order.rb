class Order < ActiveRecord::Base
  belongs_to :admin_user
  has_one :user, dependent: :destroy
  has_many :addresses, dependent: :destroy
  accepts_nested_attributes_for :addresses, allow_destroy: true
  accepts_nested_attributes_for :user, allow_destroy: true

  after_initialize :generate_tokens
  
  validates :admin_user, :user, presence: true
  validates :order_number, uniqueness: true, numericality: true, length: { is: 5 }
  validates :security_key, numericality: true, length: { is: 5 }

  private

  def generate_tokens
    return unless self.new_record?
    self.order_number = rand(11111..99999)
    self.security_key = rand(11111..99999)
  end
end
