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
  has_many :daily_summaries, dependent: :destroy

  delegate :name, to: :club, prefix: true

  SUMMARY_TYPES = ['membership', 'training', 'juice_bar', 'nursery']

  def self.for_club(club_id)
  	where(:club_id => club_id)
  end

  def self.for_month(date)
    where(:month => date).order('club_id')
  end

  def membership_cash_to_date
    @membership_cash_to_date ||= self.daily_summaries.sum('membership_cash')
  end

  def training_cash_to_date
    @training_cash_to_date ||= self.daily_summaries.sum('training_cash')
  end

  def juice_bar_cash_to_date
    @juice_bar_cash_to_date ||= self.daily_summaries.sum('juice_bar_cash')
  end

  def nursery_cash_to_date
    @nursery_cash_to_date ||= self.daily_summaries.sum('nursery_cash')
  end

  def membership_percent_complete
    membership_cash_to_date / self.membership_goal
  end

  def training_percent_complete
    training_cash_to_date / self.training_goal
  end

  def juice_bar_percent_complete
    juice_bar_cash_to_date / self.juice_bar_goal
  end

  def nursery_percent_complete
    nursery_cash_to_date / self.nursery_goal
  end

  def membership_projected_cash
    (membership_cash_to_date / self.daily_summaries.count) * self.business_days_in_month
  end

  def training_projected_cash
    (training_cash_to_date / self.daily_summaries.count) * self.business_days_in_month
  end

  def juice_bar_projected_cash
    (juice_bar_cash_to_date / self.daily_summaries.count) * self.business_days_in_month
  end

  def nursery_projected_cash
    (nursery_cash_to_date / self.daily_summaries.count) * self.business_days_in_month
  end
end
