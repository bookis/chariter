require 'spec_helper'

describe Commitment do
  let(:commitment) { Commitment.new }
  
  describe "money" do
    it "amount should be Money" do
      commitment.amount.should be_an_instance_of Money
    end
    
    it "credit should be Money" do
      commitment.amount.should be_an_instance_of Money
    end
  end
end
