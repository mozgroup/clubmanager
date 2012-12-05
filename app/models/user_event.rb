# == Schema Information
#
# Table name: user_events
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  event_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class UserEvent < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  
  def self.for_user(user_id)
    where(user_id: user_id)
  end

  def self.for_week(date)
    joins(:event).where('events.start_at >= ? AND events.start_at <= ?', date.at_beginning_of_week(:sunday), date.at_end_of_week(:sunday))
  end
end
