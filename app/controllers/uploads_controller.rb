class UploadsController < ApplicationController
  def create
    if !params[:qqfile].blank?
      order = Order.where(order_number: params[:order_order_number]).first
      upload = order.uploads.build
      upload.attachment = params[:qqfile]
      if upload.save
        render :text => '{"success": true}'
      else
        render :text => upload.errors.to_yaml
      end
    end
  end
end
