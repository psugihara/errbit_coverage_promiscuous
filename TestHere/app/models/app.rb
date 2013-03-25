require 'json'

class App
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, :type => String

  has_many :problems, :inverse_of => :app, :dependent => :destroy

  after_update :store_cached_attributes_on_problems

  validates_presence_of :name
  validates_uniqueness_of :name, :allow_blank => true

  include Promiscuous::Subscriber
  subscribe :name, :problems

  # Mongoid Bug: find(id) on association proxies returns an Enumerator
  def self.find_by_id!(app_id)
    find app_id
  end

  def notification_recipients
    if notify_all_users
      (User.all.map(&:email).reject(&:blank?) + watchers.map(&:address)).uniq
    else
      watchers.map(&:address)
    end
  end

  # Copy app attributes from another app.
  def copy_attributes_from(app_id)
    if copy_app = App.where(:_id => app_id).first
      # Copy fields
      (copy_app.fields.keys - %w(_id name created_at updated_at)).each do |k|
        self.send("#{k}=", copy_app.send(k))
      end
      # Clone the embedded objects that can be changed via apps/edit (ignore errs & deploys, etc.)
      %w(watchers issue_tracker notification_service).each do |relation|
        if obj = copy_app.send(relation)
          self.send("#{relation}=", obj.is_a?(Array) ? obj.map(&:clone) : obj.clone)
        end
      end
    end
  end

  def problem_count
    @problem_count ||= problems.count
  end

  # Compare by number of unresolved errs, then problem counts.
  def <=>(other)
    (other.unresolved_count <=> unresolved_count).nonzero? ||
    (other.problem_count <=> problem_count).nonzero? ||
    name <=> other.name
  end

  # Count the number of times files occur at the top of a stacktrace.
  def files_needing_coverage
    file_occurences = {}
    file_occurences.default = 0

    problems.each do |problem|
      line = problem.errs.first.notices.first.backtrace.lines.first
      file = line.to_s.split('/').last.split(':').first
      file_occurences[file] += problem.notices_count
    end

    file_occurences
  end

  protected

    def store_cached_attributes_on_problems
      problems.each(&:cache_app_attributes)
    end
end

