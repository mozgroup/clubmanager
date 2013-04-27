# == Schema Information
#
# Table name: tasks
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  due_at        :datetime
#  completed_at  :datetime
#  context_id    :integer
#  project_id    :integer
#  owner_id      :integer
#  notes         :text
#  state         :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  assignee_id   :integer
#  started_at    :datetime
#  claimed_at    :datetime
#  priority      :integer
#  department_id :integer
#

class Task < ActiveRecord::Base
  include PgSearch

  attr_accessible :completed_at, :context_id, :due_at, :name, :notes, :owner_id, :project_id, :state, :context_name, :project_name, :assigned_to, :assignee_id, :priority, :department_id

  belongs_to :context
  belongs_to :owner, class_name: 'User', foreign_key: :owner_id
  belongs_to :assignee, class_name: 'User', foreign_key: :assignee_id
  belongs_to :project
  belongs_to :department

  validates :name, presence: true
  validates :due_at, presence: true

  delegate :name, to: :context, prefix: true, allow_nil: true
  delegate :name, to: :project, prefix: true, allow_nil: true
  delegate :full_name, to: :assignee, prefix: true, allow_nil: true
  delegate :full_name, to: :owner, prefix: true, allow_nil: true
  delegate :name, to: :department, prefix: true, allow_nil: true

  pg_search_scope :search_for,
                  {
                    :against => [:name, :notes, :state],
                    :associated_against => {
                      :department => :name,
                      :owner => [:first_name, :last_name],
                      :assignee => [:first_name, :last_name],
                      :project => :name
                    },
                    :using => :dmetaphone
                  }

  include SysLogger

  state_machine initial: :new do
    event :assign do
      transition [:new, :claimed, :assigned] => :assigned
    end

    event :claim do
      transition [:assigned] => :claimed
    end

    event :start do
      transition [:assigned, :claimed] => :started
    end

    event :complete do
      transition [:started] => :completed
    end
  end

  def self.by_name
    order(:name)
  end

  def self.by_state
    order(:state)
  end

  def self.by_department
    joins(:department).order('departments.name')
  end

  def self.by_context(context_id)
    where('context_id = ?', context_id)
  end

  def self.by_project(project_id)
    where('project_id = ?', project_id)
  end

  def self.by_assigned_user(user_id)
    where('assignee_id = ?', user_id)
  end

  def self.in_process
    where('state in (?)', %w(assigned claimed started))
  end

  def self.not_complete
    where("state != 'new' AND state != 'completed")
  end

  def self.for_week(date)
    where('due_at >= ? AND due_at <= ?', date.at_beginning_of_week(:sunday), date.at_end_of_week(:sunday))
  end

  def self.order_by_priority
    order('priority ASC')
  end

  def self.rebuild_pg_search_documents
    find_each { |record| record.update_pg_search_document }
  end

  def context_name=(name)
    add_context({ name: name, owner_id: self.owner_id })
  end

  def project_name=(name)
    add_project({ name: name, owner_id: self.owner_id, context_id: self.context_id })
  end

  def assigned_to=(name)
    unless name.blank?
      add_assignment name
      self.assign
    end
  end

  def assigned_to
    self.assignee_full_name
  end

  def has_assignee?
    ! self.assignee.nil?
  end

  def is_not_complete?
    ! self.completed?
  end

  def update_assigned_to(name)
    self.assigned_to = name
    self.assign
  end

  def claim_task
    self.claim
  end

  def start_task
    self.start
  end

  def complete_task
    self.complete
  end

  def method_missing(method, *args)
    if method.to_s == "add_context" || method.to_s == "add_project"
      class_name = method.slice(/_(.+)/,1)
      self.send("#{class_name}=".to_sym, find_or_create_by_name(class_name.to_sym, args[0]))
    else
      super
    end
  end

  private

    def find_or_create_by_name(class_name, params)
      klass = class_name.to_s.camelize.constantize
      obj = klass.find_by_name(params[:name]) || klass.create(params)
    end

    def add_assignment(name)
      user = User.find_by_full_name(name)
      self.assignee_id = user.id unless user.nil?
    end
end
