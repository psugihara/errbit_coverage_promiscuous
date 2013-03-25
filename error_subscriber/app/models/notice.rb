class Notice < ActiveRecord::Base
  attr_accessible :message, :errbit_id

  include Promiscuous::Subscriber
  subscribe :created_at, :message, :foreign_key => :errbit_id
end
