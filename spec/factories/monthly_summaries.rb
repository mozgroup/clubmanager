# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :monthly_summary do
    month 1
    club_id 1
    business_days_in_month 1
    membership_goal "9.99"
    training_goal "9.99"
    juice_bar_goal "9.99"
    nursery_goal "9.99"
    membership_draft_expected "9.99"
    training_draft_expected "9.99"
  end
end
