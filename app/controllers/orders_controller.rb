class OrdersController < ApplicationController
  before_filter :authenticate_user!

  def show
    @order = current_user.order
    redirect_to order_path(@order) if @order.order_number != params[:order_number].to_i
  end

  def destroy_uploads
    order = current_user.order
    order.uploads.delete_all
    redirect_to({action: :show})
  end

  def waiting_for_review
    order = current_user.order.waiting_for_review!
    redirect_to({action: :show})
  end
end
