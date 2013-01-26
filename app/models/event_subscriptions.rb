# == Schema Information
#
# Table name: event_subscriptions
#
#  id         :integer          not null, primary key
#  event_id   :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class EventSubscriptions < ActiveRecord::Base
  belongs_to :event
  belongs_to :user
end
