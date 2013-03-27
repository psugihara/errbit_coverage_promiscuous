class Backtrace
  include Mongoid::Document
  include Mongoid::Timestamps

  embeds_many :lines, :class_name => "BacktraceLine"

  include Promiscuous::Subscriber
  subscribe :lines
end
