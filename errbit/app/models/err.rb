# Represents a set of Notices which can be automatically
# determined to refer to the same Error (Errbit groups
# notices into errs by a notice's fingerprint.)

class Err
  include Mongoid::Document
  include Mongoid::Timestamps
  include Promiscuous::Publisher

  publish do
    field :error_class, :default => "UnknownError"
    field :component
    field :action
    field :environment, :default => "unknown"
    field :fingerprint

    belongs_to :problem
    track_dependencies_of :problem_id
  end

  index({ problem_id: 1 })
  index({ error_class: 1 })
  index({ fingerprint: 1 })

  has_many :notices, :inverse_of => :err, :dependent => :destroy

  delegate :app, :resolved?, :to => :problem

end

