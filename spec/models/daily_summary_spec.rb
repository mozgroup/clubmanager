# == Schema Information
#
# Table name: daily_summaries
#
#  id                             :integer          not null, primary key
#  monthly_summary_id             :integer
#  membership_cash                :decimal(8, 2)
#  training_cash                  :decimal(8, 2)
#  juice_bar_cash                 :decimal(8, 2)
#  nursery_cash                   :decimal(8, 2)
#  membership_draft_cash          :decimal(8, 2)
#  training_draft_cash            :decimal(8, 2)
#  membership_cancellations       :integer
#  membership_cancellations_value :decimal(8, 2)
#  membership_freezes             :integer
#  membership_freezes_value       :decimal(8, 2)
#  membership_delinquents         :integer
#  membership_delinquents_value   :decimal(8, 2)
#  training_cancellations         :integer
#  training_cancellations_value   :decimal(8, 2)
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#

require 'spec_helper'

describe DailySummary do
  pending "add some examples to (or delete) #{__FILE__}"
end
