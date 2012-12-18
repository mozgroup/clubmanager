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

class MonthlySummary < ActiveRecord::Base
  attr_accessible :business_days_in_month, :club_id, :juice_bar_goal, :membership_draft_expected, :membership_goal, :month, :nursery_goal, :training_draft_expected, :training_goal

  validates :club_id, presence: true
  validates :month, presence: true
  validates :business_days_in_month, presence: true
  validates :membership_goal, presence: true
  validates :training_goal, presence: true
  validates :juice_bar_goal, presence: true
  validates :membership_draft_expected, presence: true
  validates :training_draft_expected, presence: true

  belongs_to :club

  delegate :name, to: :club, prefix: true

  def self.for_club(club_id, current_date)
  	where(:club_id => club_id, :month => current_date)
  end
end
