# == Schema Information
#
# Table name: envelopes
#
#  id           :integer          not null, primary key
#  message_id   :integer
#  recipient_id :integer
#  read_flag    :boolean
#  trash_flag   :boolean
#  delete_flag  :boolean
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Envelope < ActiveRecord::Base
  attr_accessible :delete_flag, :message_id, :read_flag, :recipient_id, :trash_flag

  belongs_to :message
  belongs_to :recipient, class_name: 'User', foreign_key: :recipient_id

  scope :belongs_to_user, lambda { |user| where(recipient_id: user.id) }
  scope :inbox, where(trash_flag: false)
end
