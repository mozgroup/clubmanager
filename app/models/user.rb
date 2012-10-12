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
  has_many :envelopes, foreign_key: :recipient_id, order: "delivered_at DESC" do
    def inbox
      where("trash_flag = ? and author_flag = ?", false, false)
    end

    def unread_count
      where("trash_flag = ? and read_flag = ? and author_flag = ?", false, false, false).count
    end

    def trash
      where("trash_flag = ?", true)
    end
  end
  has_many :messages, through: :envelopes
  has_many :authored_messages, class_name: 'Message', foreign_key: :author_id do
    def sent
      where("status = ?", Message::StatusSent).order("sent_at DESC")
    end

    def drafts
      where("status = ?", Message::StatusDraft).order("created_at DESC")
    end
  end
  has_many :projects, foreign_key: :owner_id
  has_many :contexts, foreign_key: :owner_id
  has_many :tasks, foreign_key: :owner_id
  has_many :top_tasks, class_name: 'Task', foreign_key: :owner_id, order: :due_at, limit: 3

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :employee_number, presence: true

  accepts_nested_attributes_for :club_users

  include SysLogger

  def self.name_search(query)
    if query.present?
      User.where('first_name ilike :q or last_name ilike :q', q: "%#{query}%") 
    else
      scoped
    end
  end

  def self.find_by_full_name(name)
    User.find_by_first_name_and_last_name(*name.split(' ',2))
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def update_tracked_fields!(request)
    self.log_signin("#{full_name} has been signed in", full_name)

    super(request)
  end
end
