class Notice < ActiveRecord::Base
  attr_accessible :message


  include Promiscuous::Subscriber
  subscribe :created_at, :message
end
