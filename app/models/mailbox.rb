# == Schema Information
#
# Table name: mailboxes
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  name            :string(255)
#  host            :string(255)
#  port            :string(255)
#  ssl             :boolean
#  domain          :string(255)
#  username        :string(255)
#  password_digest :string(255)
#  starttls_auto   :boolean
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Mailbox < ActiveRecord::Base
  has_secure_password

  belongs_to :user
  attr_accessible :user_id, :domain, :host, :name, :password, :port, :ssl, :starttls_auto, :username

  validates :name, presence: true
  validates :host, presence: true
  validates :username, presence: true
end
