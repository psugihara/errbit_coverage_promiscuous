class Err < ActiveRecord::Base

  include Promiscuous::Subscriber
  subscribe :message, :server_environment, :request, :notifier, :user_attributes,
  :framework, :error_class, :lines, :app

  after_create { Rails.logger.info "Error: #{message}" }
end
