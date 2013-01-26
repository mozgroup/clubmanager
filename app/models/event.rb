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
  attr_accessible :organizer_id, :summary, :description, :starts_at_time, :starts_at_date, :ends_at_date

# after_create :add_organizer_as_subscriber

  validates :summary, presence: true
  validates :starts_at_date, presence: true

  belongs_to :organizer, class_name: 'User', foreign_key: :organizer_id
  has_many :subscriptions, class_name: 'EventSubscriptions', dependent: :destroy
  has_many :subscribers, through: :subscriptions, source: :user

  delegate :full_name, to: :organizer, prefix: true

  include SysLogger

  scope :subscribed_to, lambda { |user| joins(:subscribers).where('event_subscriptions.user_id = ?', user.id) }
  scope :for_month, lambda { |date| where('starts_at_date >= :b AND starts_at_date <= :e', b: date.beginning_of_month, e: date.end_of_month) }
  scope :for_week, lambda { |date| where('starts_at_date >= :b AND starts_at_date <= :e', b: date.beginning_of_week(:sunday), e: date.end_of_week(:sunday)) }

  def is_subscriber?(user)
    self.subscribers.include?(user)
  end

  state_machine initial: :draft do
    event :send_invite do
      transition [:draft, :sent] => :sent
    end

    after_transition :on => :send_invite, :do => :setup_attendees
  end

  private

    after_create do |event|
      event.subscribers << self.organizer
    end

end
