class Order < ActiveRecord::Base
  include AASM
  belongs_to :admin_user
  has_one :user, dependent: :destroy
  has_many :addresses, dependent: :destroy
  accepts_nested_attributes_for :addresses, allow_destroy: true
  accepts_nested_attributes_for :user, allow_destroy: false

  after_initialize :generate_tokens
  after_create do |order|
    OrderMailer.created(order).deliver
  end

  validates :admin_user, :user, presence: true
  validates :order_number, uniqueness: true, numericality: true, length: { is: 5 }
  validates :security_key, numericality: true, length: { is: 5 }

  aasm do
    state :created, :initial => true
    state :data_received_from_user
    state :pdf_sent_to_user
    state :pdf_reviewed_by_user
    state :shipped

    event :data_received_from_user,
          :after => Proc.new { OrderMailer.data_received_from_user(self).deliver } do
      transitions :from => :created, :to => :data_received_from_user
    end

    event :pdf_sent_to_user,
          :after => Proc.new { OrderMailer.pdf_sent_to_user(self).deliver } do
      transitions :from => :data_received_from_user, :to => :pdf_sent_to_user
    end

    event :pdf_reviewed_by_user,
          :after => Proc.new { OrderMailer.pdf_reviewed_by_user(self).deliver } do
      transitions :from => :pdf_sent_to_user, :to => :pdf_reviewed_by_user
    end

    event :shipped,
          :after => Proc.new { OrderMailer.shipped(self).deliver } do
      transitions :from => :pdf_reviewed_by_user, :to => :shipped
    end
  end

  def to_param
    return "#{order_number}"
  end

  private

  def generate_tokens
    return unless self.new_record?
    self.order_number = rand(11111..99999)
    self.security_key = rand(11111..99999)
  end
end
