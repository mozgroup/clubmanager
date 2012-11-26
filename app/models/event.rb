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

  belongs_to :user

  validates :subject, presence: true
  validates :start_at, presence: true
  validates :end_at, presence: true

  delegate :full_name, to: :user, prefix: true

  scope :for_user, lambda { |user_id| where(user_id: user_id) }
  scope :on, lambda { |start_at, end_at| where('start_at >= ? AND start_at <= ?', start_at, end_at).order(:start_at) }
end
