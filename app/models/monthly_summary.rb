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
  DRAFT_TYPES = ['membership_draft', 'training_draft']

  def self.for_club(club_id)
  	where(:club_id => club_id)
  end

  def self.for_month(date)
    where(:month => date).order('club_id')
  end

  def cash_to_date(column)
    self.daily_summaries.sum("#{column}_cash")
  end

  def percent_complete(column)
    cash_to_date(column) / send("#{column}_goal")
  end

  def projected_cash(column)
    (cash_to_date(column) / self.daily_summaries.count) * self.business_days_in_month
  end

  def over_under(column)
    projected_cash(column) - send("#{column}_goal")
  end

  def membership_draft_cash_to_date
    self.daily_summaries.sum("membership_draft_cash")
  end

  def training_draft_cash_to_date
    self.daily_summaries.sum("training_draft_cash")
  end

  private

    def memoize(i_var, &block)
      instance_var = "@#{i_var}".to_sym

      unless instance_variable_defined?(instance_var)
        if block_given?
          yield instance_var
        else
          "no block given"
        end
      end

      instance_variable_get(instance_var)
    end
end
