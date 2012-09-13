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

require 'spec_helper'

describe ClubUsers do

  it { should belong_to(:club) }
  it { should belong_to(:user) }
end
