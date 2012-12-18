# == Schema Information
#
# Table name: clubs
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  region_id  :integer
#  address    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Club < ActiveRecord::Base
  attr_accessible :address, :name, :region_id

  validates :name, presence: true

  belongs_to :region
  has_many :club_users, class_name: 'ClubUsers'
  has_many :users, through: :club_users
  has_many :monthly_summaries

end
