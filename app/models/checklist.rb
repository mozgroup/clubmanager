# == Schema Information
#
# Table name: checklists
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  author_id   :integer
#  name        :string(255)
#  frequency   :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  day_of_week :integer
#

class Checklist < ActiveRecord::Base
  attr_accessible :user_id, :frequency, :name, :assigned_to, :author_id, :checklist_items_attributes, :days_of_week

  belongs_to :user
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  has_many :checklist_items, order: 'id'

  validate :name, presence: true
  validate :frequency, presence: true

  delegate :full_name, to: :user, prefix: true, allow_nil: true
  delegate :full_name, to: :author, prefix: true

  DAILY = 'daily'
  WEEKLY = 'weekly'
  SEMIWEEKLY = 'semiweekly'   # Twice weekly
  BIWEEKLY = 'biweekly'       # Every two weeks
  MONTHLY = 'monthly'
  SEMIMONTHLY = 'semimonthly' # Twice monthly
  BIMONTHLY = 'bimonthly'     # Every two months
  FREQUENCIES = [DAILY, WEEKLY, MONTHLY]
  DAYS_OF_WEEK = %w[sunday monday tuesday wednesday thursday friday saturday]

  scope :with_day_of_week, lambda { |dow| { conditions: "days_of_week_mask & #{2**DAYS_OF_WEEK.index(dow.to_s)} > 0"} }

  accepts_nested_attributes_for :checklist_items, allow_destroy: true

  def self.for_user(user_id)
    where(user_id: user_id)
  end

  def assigned_to
    user_full_name
  end

  def assigned_to=(name)
    user = User.find_by_full_name(name)
    self.user_id = user.id unless user.nil?
  end

  def is_daily?
    frequency == 'daily'
  end

  def is_weekly?
    frequency == 'weekly'
  end
  
  def is_monthly?
    frequency == 'monthly'
  end

  def days_of_week=(days)
    self.days_of_week_mask = (days & DAYS_OF_WEEK).map { |d| 2**DAYS_OF_WEEK.index(d) }.sum
  end

  def days_of_week
    DAYS_OF_WEEK.reject { |d| ((days_of_week_mask || 0) & 2**DAYS_OF_WEEK.index(d)).zero? }
  end

  def day_of_week(day)
    case day
    when 'sunday'
      0
    when 'monday'
      1
    when 'tuesday'
      2
    when 'wednesday'
      3
    when 'thursday'
      4
    when 'friday'
      5
    when 'saturday'
      6
    end
  end
end
