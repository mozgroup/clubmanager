# == Schema Information
#
# Table name: sys_logs
#
#  id            :integer          not null, primary key
#  message       :text
#  message_type  :string(255)
#  actioned_by   :string(255)
#  loggable_id   :integer
#  loggable_type :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class SysLog < ActiveRecord::Base
  attr_accessible :actioned_by, :message, :message_type
  belongs_to :loggable, polymorphic: true

  validates :actioned_by, presence: true
  validates :message, presence: true
  validates :message_type, presence: true
end
