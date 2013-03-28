class Notice
  include Mongoid::Document
  include Mongoid::Timestamps
  include Promiscuous::Subscriber

  subscribe do
    field :message
    field :server_environment, :type => Hash
    field :request, :type => Hash
    field :notifier, :type => Hash
    field :user_attributes, :type => Hash
    field :framework
    field :error_class

    belongs_to :backtrace, :index => true
  end

end
