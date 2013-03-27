class Notice
  include Mongoid::Document
  include Mongoid::Timestamps
  include Promiscuous::Subscriber

  # has_one :backtrace
  # field :backtrace_id_s

  # subscribe :backtrace_id_s

  field :message
  subscribe :message
  
  before_validation { Rails.logger.info 'notice:before_validation' }
  before_create { Rails.logger.info 'notice:before_create' }
  after_create { Rails.logger.info 'created notice' }
end
