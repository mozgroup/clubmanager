# == Schema Information
#
# Table name: envelopes
#
#  id           :integer          not null, primary key
#  message_id   :integer
#  recipient_id :integer
#  read_flag    :boolean          default(FALSE)
#  trash_flag   :boolean          default(FALSE)
#  delete_flag  :boolean          default(FALSE)
#  delivered_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Envelope < ActiveRecord::Base
  attr_accessible :delete_flag, :message_id, :read_flag, :recipient_id, :trash_flag, :delivered_at

# before_create :update_delivered_at

  belongs_to :message
  belongs_to :recipient, class_name: 'User', foreign_key: :recipient_id

  delegate :importance, to: :message, prefix: true

  def sender_full_name
    self.message.author_full_name
  end

  def is_read?
    self.read_flag
  end

  def is_important?
    message_importance == Message::Important
  end

  protected

    def update_delivered_at
      self.delivered_at = Time.zone.now
    end
end
