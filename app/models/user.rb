# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  employee_number :string(255)
#  first_name      :string(255)
#  last_name       :string(255)
#  email           :string(255)
#  password_digest :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  attr_accessible :email, :employee_number, :first_name, :last_name, :password, :password_confirmation

  ValidEmailRegex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: ValidEmailRegex }, uniqueness: { case_sensitive: false }
  validates :first_name, presence: true
  validates :employee_number, presence: true, numericality: true

  has_secure_password

  def full_name
    "#{self.first_name} #{self.last_name}"
  end
end
