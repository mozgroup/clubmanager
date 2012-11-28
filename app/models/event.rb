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
#

class Event < ActiveRecord::Base
  attr_accessible :description, :end_at, :invitee_list, :location, :start_at, :subject, :user_id

  belongs_to :organizer, class_name: 'User', foreign_key: :user_id
  has_many :user_events
  has_many :users, through: :user_events

  validates :subject, presence: true
  validates :start_at, presence: true
  validates :end_at, presence: true

  delegate :full_name, to: :user, prefix: true

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
        self.users << user if user
        Notifier::Events.deliver_invitation self, user
      end
    end
  end
end
