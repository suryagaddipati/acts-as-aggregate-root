class Order < ActiveRecord::Base
  acts_as_aggregate_root
  has_many :sub_orders
end
