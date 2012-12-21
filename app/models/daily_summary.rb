class DailySummary < ActiveRecord::Base
  attr_accessible :juice_bar_cash, :membership_cancellations, :membership_cancellations_value, :membership_cash, :membership_delinquents, :membership_delinquents_value, :membership_draft_cash, :membership_freezes, :membership_freezes_value, :monthly_summary_id, :nursery_cash, :training_cancellations, :training_cancellations_value, :training_cash, :training_draft_cash
end
