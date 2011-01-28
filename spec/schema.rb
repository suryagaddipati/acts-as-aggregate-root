ActiveRecord::Schema.define :version => 0 do
  create_table "orders", :force => true do |t|
    t.timestamps  
  end


  create_table "sub_orders", :force => true do |t|
    t.column :order_id, :integer
  end
  
end
