class OrderMailer < ActionMailer::Base
  default from: "info@pionira-medical.com"

  def waiting_for_upload(order)
    @order = order
    mail(to: @order.user.email, subject: 'Ihr Auftrag bei Pionira-Medical')
  end

  def waiting_for_review(order)
    @order = order
    mail(to: @order.admin_user.email, subject: 'waiting_for_review')
  end

  def in_production(order)
  	@order = order
    mail(to: @order.user.email, subject: 'in_production')
  end
end
