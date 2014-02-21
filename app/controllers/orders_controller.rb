class OrdersController < ApplicationController
  before_filter :authenticate_user!
  
  def show
    @order = current_user.order
    redirect_to order_path(@order) if @order.order_number != params[:order_number].to_i
  end
end
