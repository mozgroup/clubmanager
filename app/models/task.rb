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
  attr_accessible :completed_at, :context_id, :due_at, :name, :notes, :owner_id, :project_id, :state

  belongs_to :context
  belongs_to :owner, class_name: 'User', foreign_key: :owner_id
  belongs_to :project

  validates :name, presence: true
  validates :due_at, presence: true
end
