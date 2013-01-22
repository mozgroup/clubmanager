# == Schema Information
#
# Table name: events
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  invitee_list :string(255)
#  subject      :string(255)
#  location     :string(255)
#  description  :text
#  start_at     :datetime
#  end_at       :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  state        :string(255)
#

class Event < ActiveRecord::Base
  attr_accessible :description, :end_at, :invitee_list, :location, :start_at, :subject, :user_id, :event_time, :event_date

  belongs_to :organizer, class_name: 'User', foreign_key: :user_id
  has_many :user_events, dependent: :destroy
  has_many :users, through: :user_events

  validates :subject, presence: true
#  validates :start_at, presence: true
#  validates :end_at, presence: true

  delegate :full_name, to: :organizer, prefix: true

  include SysLogger

  state_machine initial: :draft do
    event :send_invite do
      transition [:draft, :sent] => :sent
    end

    after_transition :on => :send_invite, :do => :setup_attendees
  end

  def setup_attendees
    self.users << self.organizer

    unless self.invitee_list.blank?
      self.invitee_list.split(/,\s*/).each do |attendee|
        user = User.find_by_full_name attendee
        self.users << user if user && user != self.organizer
        Notifier::Events.deliver_invitation self, user
      end
    end
  end

  def self.for_week(date)
    where('start_at >= ? AND start_at <= ?', date.at_beginning_of_week(:sunday), date.at_end_of_week(:sunday))
  end

  def event_time
  end

  def event_time=(time)
  end

  def event_date
  end

  def event_date=(date)
  end
end
