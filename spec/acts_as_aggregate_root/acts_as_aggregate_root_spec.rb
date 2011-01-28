require File.expand_path('../../spec_helper', __FILE__)

describe "Acts As Taggable On" do
  before(:each) do
    clean_database!
  end

  it "should delete sub-order if order is deleted" do
    o = Order.new(:sub_orders => [SubOrder.new])
    o.save(false)
    o.destroy
    Order.all.count.should == 0
    SubOrder.all.count.should == 0
  end

  it "should delete sub-order if order is deleted" do
    o = Order.new(:sub_orders => [SubOrder.new(:order_items => [OrderItem.new] )])
    o.save(false)
    o.destroy
    Order.all.count.should == 0
    SubOrder.all.count.should == 0
    OrderItem.all.count.should == 0
  end
end
