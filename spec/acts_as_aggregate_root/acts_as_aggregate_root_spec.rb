require File.expand_path('../../spec_helper', __FILE__)

describe "Acts as Aggregate Root" do
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
  
  it "should save sub-order if order is saved" do
    o = Order.new(:sub_orders => [SubOrder.new])
    o.save(false)
    
    o.name = "OrderName"
    o.sub_orders.first.name = "SubOrderName"
    o.save
    
    Order.first.name.should == "OrderName"
    SubOrder.first.name.should == "SubOrderName"

  end
  
  it "should save sub-order if order is saved" do
    o = Order.new(:sub_orders => [SubOrder.new(:order_items => [OrderItem.new])])
    o.save(false)
    
    o.name = "OrderName"
    o.sub_orders.first.order_items.first.name = "OrderItemName"
    o.save
    
    Order.first.name.should == "OrderName"
    OrderItem.first.name.should == "OrderItemName"

  end
end
