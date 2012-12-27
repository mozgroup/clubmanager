class CheckList < ActiveRecord::Base
  attr_accessible :frequency, :name, :user_id

  belongs_to :user
  has_many :check_list_items

  validate :name, presence: true
  validate :frequency, presence: true

  DAILY = 'daily'
  WEEKLY = 'weekly'
  SEMIWEEKLY = 'semiweekly'   # Twice weekly
  BIWEEKLY = 'biweekly'       # Every two weeks
  MONTHLY = 'monthly'
  SEMIMONTHLY = 'semimonthly' # Twice monthly
  BIMONTHLY = 'bimonthly'     # Every two months

end
