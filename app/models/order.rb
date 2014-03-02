class Order < ActiveRecord::Base
  include AASM
  belongs_to :admin_user
  has_one :user, dependent: :destroy
  has_many :addresses, dependent: :destroy
  accepts_nested_attributes_for :addresses, allow_destroy: true
  accepts_nested_attributes_for :user, allow_destroy: false

  after_initialize :generate_tokens

  validates :admin_user, :user, presence: true
  validates :order_number, uniqueness: true, numericality: true, length: { is: 5 }
  validates :security_key, numericality: true, length: { is: 5 }

  aasm do
    state :waiting_for_upload, :initial => true
    state :waiting_for_review
    state :in_production
    state :invoiced
    state :closed

    initial_state do
      OrderMailer.waiting_for_upload(self).deliver
    end

    event :waiting_for_review do
      after do
        OrderMailer.waiting_for_review(self).deliver
      end
      transitions :from => :waiting_for_upload, :to => :waiting_for_review
    end

    event :in_production do
      after do
        OrderMailer.in_production(self).deliver
      end
      transitions :from => :waiting_for_review, :to => :in_production
    end
  end

  def to_param
    return "#{order_number}"
  end

  private

  def generate_tokens
    return if self.order_number.present? && self.security_key.present?
    self.order_number = rand(11111..99999)
    self.security_key = rand(11111..99999)
  end
end
