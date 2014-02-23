require 'spec_helper'

describe Order do
  it "has a valid factory" do
    expect(FactoryGirl.create(:order_with_addresses).addresses.size).to eq(2)
  end
  it "is invalid without a associated user" do
    expect(FactoryGirl.build(:order, user: nil)).to_not be_valid
  end
  it "is invalid without a order_number" do
    expect(FactoryGirl.build(:order, order_number: nil)).to_not be_valid
  end
  it "is invalid without a security_key" do
    expect(FactoryGirl.build(:order, security_key: nil)).to_not be_valid
  end
  it "sends new order mail to user" do
    order = FactoryGirl.create(:order)
    expect(ActionMailer::Base.deliveries.last.to).to eq([order.user.email])
  end

  context "when initialized" do
    before(:each) { @order = FactoryGirl.create(:order) }

    it "has the initial state" do
      expect(@order.aasm_state).to eq('created')
    end
    it "can change the state" do
      @order.data_received_from_user
      expect(@order.aasm_state).to eq('data_received_from_user')
    end
    it "sends a mail when the state has changed to data_received_from_user" do
      @order.data_received_from_user
      
    end
    it "sends a mail when the state has changed" do
      @order.data_received_from_user
      expect(ActionMailer::Base.deliveries.last.to).to eq([@order.admin_user.email])
      @order.pdf_sent_to_user
      expect(ActionMailer::Base.deliveries.last.to).to eq([@order.user.email])
      @order.pdf_reviewed_by_user
      expect(ActionMailer::Base.deliveries.last.to).to eq([@order.admin_user.email])
      @order.shipped
      expect(ActionMailer::Base.deliveries.last.to).to eq([@order.user.email])
    end
  end
end
