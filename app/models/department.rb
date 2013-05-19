# == Schema Information
#
# Table name: departments
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  manager_id  :integer
#

class Department < ActiveRecord::Base
  attr_accessible :description, :name, :manager_id

  has_many :tasks
  belongs_to :manager, class_name: 'User', foreign_key: :manager_id
  has_many :users

  validates :name, presence: true

  scope :by_name, order(:name)
  scope :for_manager, lambda { |manager| where(manager_id: manager.id) }

end
