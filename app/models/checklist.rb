class Checklist < ActiveRecord::Base
  attr_accessible :frequency, :name, :user_id

  belongs_to :user
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  has_many :checklist_items

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
