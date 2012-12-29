# == Schema Information
#
# Table name: checklists
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  author_id  :integer
#  name       :string(255)
#  frequency  :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Checklist < ActiveRecord::Base
  attr_accessible :frequency, :name, :assigned_to, :author_id, :checklist_items_attributes

  belongs_to :user
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  has_many :checklist_items, order: 'id'

  validate :name, presence: true
  validate :frequency, presence: true

  delegate :full_name, to: :user, prefix: true, allow_nil: true

  DAILY = 'daily'
  WEEKLY = 'weekly'
  SEMIWEEKLY = 'semiweekly'   # Twice weekly
  BIWEEKLY = 'biweekly'       # Every two weeks
  MONTHLY = 'monthly'
  SEMIMONTHLY = 'semimonthly' # Twice monthly
  BIMONTHLY = 'bimonthly'     # Every two months
  FREQUENCY_LIST = [DAILY, WEEKLY, MONTHLY]

  accepts_nested_attributes_for :checklist_items, allow_destroy: true

  def assigned_to
    user_full_name
  end

  def assigned_to=(name)
    user = User.find_by_full_name(name)
    self.user_id = user.id unless user.nil?
  end

  def self.frequency
    FREQUENCY_LIST.collect { |f| f.camelize }
  end
end
