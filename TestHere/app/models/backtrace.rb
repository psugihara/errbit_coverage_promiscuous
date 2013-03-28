class Backtrace
  include Mongoid::Document
  include Mongoid::Timestamps
  include Promiscuous::Subscriber

  embeds_many :lines, :class_name => "BacktraceLine"

  subscribe do
    field :lines
  end

end
