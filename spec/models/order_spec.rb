require 'spec_helper'

describe Order do
  it "has a valid factory" do
    expect(FactoryGirl.create(:order)).to be_valid
  end
  it "is invalid without a associated user" do
    expect(FactoryGirl.build(:order, user: nil)).to_not be_valid
  end
end
