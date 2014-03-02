require 'spec_helper'

describe OrderMailer do
  describe 'create' do
    let(:order) { FactoryGirl.create(:order_with_addresses) }
    let(:mail) { OrderMailer.waiting_for_upload(order).deliver }

    it 'renders the subject' do
      expect(mail.subject).to eq('Ihr Auftrag bei Pionira-Medical')
    end
    it 'assigns addresses' do
      expect(mail.body.encoded).to include(order.addresses.first.title)
      expect(mail.body.encoded).to include(order.addresses.last.title)
    end
  end
end
