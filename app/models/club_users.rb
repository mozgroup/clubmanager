# == Schema Information
#
# Table name: club_users
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  club_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ClubUsers < ActiveRecord::Base
  attr_accessible :club_id, :user_id

  belongs_to :club
  belongs_to :user

end
