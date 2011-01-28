class OrderItem < ActiveRecord::Base
  belongs_to :sub_order
end
