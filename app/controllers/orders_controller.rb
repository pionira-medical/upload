class OrdersController < ApplicationController
  def show
  	@order = current_user.order
  end
end
