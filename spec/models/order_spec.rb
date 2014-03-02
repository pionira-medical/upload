require 'spec_helper'

describe Order do
  it "has a valid factory" do
    expect(FactoryGirl.create(:order)).to be_valid
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
      expect(@order.aasm_state).to eq('waiting_for_upload')
    end

    it "has send a mail with the initial state" do
      expect(ActionMailer::Base.deliveries.last.to).to eq([@order.user.email])
    end

    it "can change the state" do
      @order.waiting_for_review
      expect(@order.aasm_state).to eq('waiting_for_review')
    end
    it "sends a mail when the state has changed" do
      @order.waiting_for_review
      expect(ActionMailer::Base.deliveries.last.to).to eq([@order.admin_user.email])
      @order.in_production
      expect(ActionMailer::Base.deliveries.last.to).to eq([@order.admin_user.email])
    end
  end
end
