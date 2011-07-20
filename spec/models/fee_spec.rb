require 'spec_helper'

describe Fee do

  def reset_fee(options = {})
    @valid_attributes = {
      :id => 1,
      :from_account => "RSpec is great for testing too"
    }

    @fee.destroy! if @fee
    @fee = Fee.create!(@valid_attributes.update(options))
  end

  before(:each) do
    reset_fee
  end

  context "validations" do
    
    it "rejects empty from" do
      Fee.new(@valid_attributes.merge(:from_account => "")).should_not be_valid
    end

    it "rejects non unique from" do
      # as one gets created before each spec by reset_fee
      Fee.new(@valid_attributes).should_not be_valid
    end
    
  end

end