class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :trackable, :validatable, authentication_keys: [:id]

  belongs_to :order
  before_create do |user|
    user.id = user.order.order_number if user.order.present?
  end

  def salutation
    if gender == 1
      return 'Sehr geehrter'
    else
      return 'Sehr geehrte'
    end
  end

  def full_name
    return "#{gender == 1 ? 'Herr' : 'Frau'} #{academic_title} #{first_name} #{last_name}"
  end
end
