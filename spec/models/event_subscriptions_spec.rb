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

require 'spec_helper'

describe EventSubscriptions do
  pending "add some examples to (or delete) #{__FILE__}"
end
