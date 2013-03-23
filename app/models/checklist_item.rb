# == Schema Information
#
# Table name: checklist_items
#
#  id           :integer          not null, primary key
#  checklist_id :integer
#  name         :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class ChecklistItem < ActiveRecord::Base
  attr_accessible :checklist_id, :name, :attachables_attributes

  belongs_to :checklist
  has_many :completes, as: :completable, dependent: :destroy
  has_many :attachments, as: :attachable, dependent: :destroy
  has_one :item_checklist, class_name: 'Checklist'

  accepts_nested_attributes_for :attachments, allow_destroy: true

  delegate :name, to: :checklist, prefix: true

  def self.for_user(user_id)
    joins(:checklist).where('checklists.user_id = ?', user_id)
  end

  def self.completes_for_today
    joins(:completes).where('completes.created_at >= ? and completes.created_at <= ?', Time.zone.now.beginning_of_day, Time.zone.now.end_of_day)
  end

  def self.completes_for_week
    joins(:completes).where('completes.created_at >= ? and completes.created_at <= ?', Time.zone.now.beginning_of_week(:sunday), Time.zone.now.end_of_week(:sunday))
  end

  def self.completes_for_month
    joins(:completes).where('completes.created_at >= ? and completes.created_at <= ?', Time.zone.now.beginning_of_month, Time.zone.now.end_of_month)
  end

  def self.with_day_of_week(dow)
    joins(:checklist).where("checklists.days_of_week_mask & #{2**Checklist::DAYS_OF_WEEK.index(dow.to_s)} > 0" )
  end

  def self.daily
    joins(:checklist).where("checklists.days_of_week_mask & #{2**Time.zone.now.wday} > 0")
#    joins(:checklist).where('checklists.frequency = ?', Checklist::DAILY)
  end

  def self.weekly
    joins(:checklist).where('checklists.frequency = ?', Checklist::WEEKLY)
  end

  def self.monthly
    joins(:checklist).where('checklists.frequency = ?', Checklist::MONTHLY)
  end

  def self.daily_incomplete_for_user(user_id)
    (for_user(user_id).daily.order(:id) - for_user(user_id).daily.completes_for_today.order(:id))
  end

  def self.weekly_incomplete_for_user(user_id)
    (for_user(user_id).weekly.order(:id) - for_user(user_id).weekly.completes_for_week.order(:id))
  end

  def self.monthly_incomplete_for_user(user_id)
    (for_user(user_id).monthly.order(:id) - for_user(user_id).monthly.completes_for_month.order(:id))
  end

  def is_complete?(date)
    start_date = date.beginning_of_day
    end_date = date.end_of_day

    if checklist.is_weekly?
      start_date = date.beginning_of_week(:sunday)
      end_date = date.end_of_week(:sunday)
    elsif checklist.is_monthly?
      start_date = date.beginning_of_month
      end_date = date.end_of_month
    end

    !completes.where('created_at >= ? and created_at <= ?', start_date, end_date).empty?
  end

  def complete
    completes.create
  end

  def undo_complete
    completes.order('created_at desc').first.destroy
  end

  def has_attachments?
    ! attachments.empty?
  end

  def has_checklist?
    item_checklist
  end
end
