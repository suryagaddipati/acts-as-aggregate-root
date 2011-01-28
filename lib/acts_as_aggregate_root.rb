require "active_record"
$LOAD_PATH.unshift(File.dirname(__FILE__))
require "acts_as_aggregate_root/acts_as_aggregate_root"
$LOAD_PATH.shift

ActiveRecord::Base.class_eval { include ActsAsAggregateRoot }
