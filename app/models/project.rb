# == Schema Information
#
# Table name: projects
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  user_id     :integer
#  position    :integer
#  context_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Project < ActiveRecord::Base
  attr_accessible :description, :name, :owner_id, :context_id

  belongs_to :owner, class_name: 'User', foreign_key: :owner_id
  belongs_to :context

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true

  delegate :name, to: :context, prefix: true, allow_nil: true
  delegate :full_name, to: :owner, prefix: true

end
