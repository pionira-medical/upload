class OrderMailer < ActionMailer::Base
  default from: "info@pionira-medical.com"
 
  def created(order)
    @order = order
    mail(to: @order.user.email, subject: 'Ihr Auftrag bei Pionira-Medical')
  end

  def data_received_from_user(order)
    @order = order
    mail(to: @order.admin_user.email, subject: 'data_received_from_user')
  end

  def pdf_sent_to_user(order)
  	@order = order
    mail(to: @order.user.email, subject: 'pdf_sent_to_user')
  end

  def pdf_reviewed_by_user(order)
  	@order = order
    mail(to: @order.admin_user.email, subject: 'pdf_sent_to_user')
  end

  def shipped(order)
  	@order = order
    mail(to: @order.user.email, subject: 'pdf_sent_to_user')
  end
end
