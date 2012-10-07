# == Schema Information
#
# Table name: tasks
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  due_at       :datetime
#  completed_at :datetime
#  context_id   :integer
#  project_id   :integer
#  owner_id     :integer
#  notes        :text
#  state        :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Task < ActiveRecord::Base
  attr_accessible :completed_at, :context_id, :due_at, :name, :notes, :owner_id, :project_id, :state, :context_name, :project_name

  belongs_to :context
  belongs_to :owner, class_name: 'User', foreign_key: :owner_id
  belongs_to :project

  validates :name, presence: true
  validates :due_at, presence: true

  delegate :name, to: :context, prefix: true, allow_nil: true
  delegate :name, to: :project, prefix: true, allow_nil: true
  delegate :full_name, to: :owner, prefix: true

  def context_name=(name)
    add_context({ name: name, owner_id: self.owner_id })
  end

  def project_name=(name)
    add_project({ name: name, owner_id: self.owner_id, context_id: self.context_id })
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
end
