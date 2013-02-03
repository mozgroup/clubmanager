# == Schema Information
#
# Table name: events
#
#  id             :integer          not null, primary key
#  organizer_id   :integer
#  summary        :text
#  description    :text
#  starts_at_time :time
#  starts_at_date :date
#  ends_at_date   :date
#

class Event < ActiveRecord::Base
  attr_accessible :organizer_id, :summary, :description, :start_time, :starts_at_date, :ends_at_date, :subscription_names

# after_create :add_organizer_as_subscriber

  validates :summary, presence: true
  validates :starts_at_date, presence: true

  belongs_to :organizer, class_name: 'User', foreign_key: :organizer_id
  has_many :subscriptions, class_name: 'EventSubscriptions', dependent: :destroy
  has_many :subscribers, through: :subscriptions, source: :user

  delegate :full_name, to: :organizer, prefix: true

  # include SysLogger

  scope :subscribed_to, lambda { |user| joins(:subscribers).where('event_subscriptions.user_id = ?', user.id) }
  scope :for_month, lambda { |date| where('ends_at_date >= :b AND ends_at_date <= :e', b: date.beginning_of_month, e: date.end_of_month) }
  scope :for_week, lambda { |date| where('ends_at_date >= :b AND ends_at_date <= :e', b: date.beginning_of_week(:sunday), e: date.end_of_week(:sunday)) }

  def is_subscriber?(user)
    self.subscribers.include?(user)
  end

  def start_time
    unless self.starts_at_time.nil?
      if self.starts_at_time.min == 0
        self.starts_at_time.strftime("%l%P")
      else
        self.starts_at_time.strftime("%l:%M%P")
      end
    end
  end

  def start_time=(time)
    unless time.blank?
      if time =~ /^(\d+):?(\d+)?(am|pm)$/
        self.starts_at_time = Time.parse(time)
      else
        self.starts_at_time = Time.zone.now
      end
    end
  end

  def subscription_names
  end

  def subscription_names=(subscribers)
    unless subscribers.blank?
      subscribers_list = subscribers.gsub(/, |,/,'|').gsub(/|$/,'').split('|')
      subscribers_list.each do |subscriber|
        user = User.find_by_full_name(subscriber)
        if user
          self.subscribers << user
        end
      end
    end
  end

  state_machine initial: :draft do
    event :send_invite do
      transition [:draft, :sent] => :sent
    end

    after_transition :on => :send_invite, :do => :setup_attendees
  end

  private

    after_create do |event|
      event.subscribers << self.organizer unless is_subscriber?(self.organizer)
    end

end
