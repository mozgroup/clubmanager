# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  failed_attempts        :integer          default(0)
#  locked_at              :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  employee_number        :string(255)
#  title                  :string(255)
#  first_name             :string(255)
#  last_name              :string(255)
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :trackable, :validatable, :lockable, :timeoutable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :title, :employee_number, :first_name, :last_name
  attr_accessible :club_ids

  has_many :club_users, class_name: 'ClubUsers'
  has_many :clubs, through: :club_users
  has_many :envelopes, foreign_key: :recipient_id
  has_many :messages, through: :envelopes
  has_many :authored_messages, class_name: 'Message', foreign_key: :author_id

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :employee_number, presence: true

  accepts_nested_attributes_for :club_users

  def full_name
    "#{first_name} #{last_name}"
  end
end
