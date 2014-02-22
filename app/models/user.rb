class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :trackable, :validatable, authentication_keys: [:id]

  belongs_to :order
  before_create do |user|
  	user.id = user.order.order_number
  end
end
