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
#  roles_mask             :integer
#  department_id          :integer
#

class User < ActiveRecord::Base
  include SysLogger

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :trackable, :validatable, :lockable, :timeoutable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :title, :employee_number, :first_name, :last_name
  attr_accessible :club_ids, :roles, :mailbox_attributes, :department_id

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :employee_number, presence: true

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
  has_many :tasks, foreign_key: :assignee_id do
    def assigned
      where("state IN (?)", ["new", "assigned", "claimed"])
    end
    def started
      where("state = ?", "started")
    end
    def completed
      where("state = ?", "completed")
    end
  end
  has_many :top_tasks, class_name: 'Task', foreign_key: :assignee_id, order: 'due_at ASC', limit: 3

  has_many :subscriptions, class_name: 'EventSubscriptions', dependent: :destroy
  has_many :events, through: :subscriptions
  has_many :organized_events, class_name: 'Event', foreign_key: 'organizer_id'
  has_many :mailboxes
  has_many :checklists
  belongs_to :department
  has_many :managed_departments, class_name: 'Department', foreign_key: 'manager_id'

  accepts_nested_attributes_for :club_users
  accepts_nested_attributes_for :mailboxes

  ROLES = %w[admin owner manager associate]

  scope :by_first_name, order(:first_name)
  scope :with_role, lambda { |role| { conditions: "roles_mask & #{2**ROLES.index(role.to_s)} > 0"} }
  scope :managers, { conditions: "roles_mask & #{2**ROLES.index('manager')} > 0"}

  def self.name_search(query)
    if query.present?
      User.where('first_name ilike :q or last_name ilike :q', q: "%#{query}%")
    else
      scoped
    end
  end

  def self.find_by_full_name(name)
    split_name = name.split(' ',2)
    User.find_by_first_name_and_last_name(*split_name) unless split_name.size == 1
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def update_tracked_fields!(request)
    self.log_signin("#{full_name} has been signed in", full_name)

    super(request)
  end

  def default_club
    self.clubs[0]
  end

  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
  end

  def roles
    ROLES.reject { |r| ((roles_mask || 0) & 2**ROLES.index(r)).zero? }
  end

  def role_symbols
    roles.map(&:to_sym)
  end

  def has_role?(role)
    roles.include? role
  end

  ROLES.each do |role|
    define_method "is_#{role}?".to_sym do
      has_role? "#{role}"
    end
  end

  def department_manager?
    !managed_departments.empty?
  end

  def manages
    if department_manager?
      sql = "SELECT * FROM users WHERE department_id IN (SELECT id FROM departments WHERE manager_id = #{self.id});"
      User.find_by_sql sql
    end
  end
end
