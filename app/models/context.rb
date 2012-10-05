# == Schema Information
#
# Table name: contexts
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  position   :integer
#  owner_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Context < ActiveRecord::Base
  attr_accessible :name, :position, :owner_id

  belongs_to :owner, class_name: 'User', foreign_key: :owner_id
  has_many :projects
  has_many :tasks

  validates :name, presence: true, uniqueness: true

  scope :by_name, order(:name)

  delegate :full_name, to: :owner, prefix: true
end
