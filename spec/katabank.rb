require 'spec_helper'

describe Katabank do
  
  before :each do
    @katabank = Katabank.new
  end
  
  it "should return number from ascii" do
    @katabank.get_number("     |  |").should == "1"
  end
end