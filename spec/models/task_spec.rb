require 'spec_helper'

describe Task do
  
  it "should be valid" do
    Task.new.should be_valid
  end
end
