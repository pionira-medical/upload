class AddressesController < ApplicationController
  before_filter :authenticate_user!

  def update
    @address = Address.find(params[:id])
    if @address.order.user_id == current_user.id
      @order.update(address_params)
    else
      render status :forbidden
    end
  end

  private

  def address_params
    params.require(:address).permit(:gender, :academic_title, :first_name, :last_name,
                                    :street_1, :street_2, :zip, :city, :phone, :email)
  end
end
