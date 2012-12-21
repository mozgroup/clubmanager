# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :daily_summary do
    monthly_summary_id 1
    membership_cash "9.99"
    training_cash "9.99"
    juice_bar_cash "9.99"
    nursery_cash "9.99"
    membership_draft_cash "9.99"
    training_draft_cash "9.99"
    membership_cancellations 1
    membership_freezes 1
    membership_delinquents 1
    training_cancellations 1
    membership_cancellations_value "9.99"
    membership_freezes_value "9.99"
    membership_delinquents_value "9.99"
    training_cancellations_value "9.99"
  end
end
