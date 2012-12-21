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

class DailySummary < ActiveRecord::Base
  attr_accessible :juice_bar_cash, :membership_cancellations, :membership_cancellations_value, :membership_cash, :membership_delinquents, :membership_delinquents_value, :membership_draft_cash, :membership_freezes, :membership_freezes_value, :monthly_summary_id, :nursery_cash, :training_cancellations, :training_cancellations_value, :training_cash, :training_draft_cash

  belongs_to :monthly_summary
  
end
