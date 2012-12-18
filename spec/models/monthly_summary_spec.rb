# == Schema Information
#
# Table name: monthly_summaries
#
#  id                        :integer          not null, primary key
#  club_id                   :integer
#  month                     :datetime
#  business_days_in_month    :integer
#  membership_goal           :decimal(8, 2)
#  training_goal             :decimal(8, 2)
#  juice_bar_goal            :decimal(8, 2)
#  nursery_goal              :decimal(8, 2)
#  membership_draft_expected :decimal(8, 2)
#  training_draft_expected   :decimal(8, 2)
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#

require 'spec_helper'

describe MonthlySummary do
  pending "add some examples to (or delete) #{__FILE__}"
end
