class BacktraceLine
  include Mongoid::Document
  IN_APP_PATH = %r{^\[PROJECT_ROOT\](?!(\/vendor))/?}
  GEMS_PATH   = %r{\[GEM_ROOT\]\/gems\/([^\/]+)}

  field :number, :type => Integer
  field :column, :type => Integer
  field :file
  field :method

  embedded_in :backtrace

  scope :in_app, where(:file => IN_APP_PATH)

  delegate :app, :to => :backtrace

  def to_s
    "#{file.to_s}:#{number}" << (column.present? ? ":#{column}" : "")
  end

end

