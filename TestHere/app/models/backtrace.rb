class Backtrace
  include Mongoid::Document
  include Mongoid::Timestamps

  field :fingerprint
  index({ fingerprint: 1 })

  has_many :notices
  has_one :notice

  embeds_many :lines, :class_name => "BacktraceLine"

  delegate :app, :to => :notice

  include Promiscuous::Subscriber
  subscribe :fingerprint, :lines, :notices, :notice

  def self.find_or_create(attributes = {})
    new(attributes).similar || create(attributes)
  end

  def similar
    Backtrace.where(fingerprint: self.fingerprint).first
  end
end
