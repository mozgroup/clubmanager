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
  attr_accessible :description, :name, :user_id, :context_id

  belongs_to :user
  belongs_to :context

  validates :name, presence: true
  validates :description, presence: true
end
