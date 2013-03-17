# == Schema Information
#
# Table name: clubs
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  region_id    :integer
#  address      :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  abbreviation :string(255)
#

require 'spec_helper'

describe Club do
  before do
    @club = FactoryGirl.build(:club)
  end

  subject { @club }

  it { should respond_to(:name) }
  it { should respond_to(:address) }
  it { should respond_to(:region_id) }

  it { should allow_mass_assignment_of(:name) }
  it { should allow_mass_assignment_of(:address) }
  it { should allow_mass_assignment_of(:region_id) }

  it { should validate_presence_of(:name) }
  
  it { should belong_to(:region) }
  it { should have_many(:users).through(:club_users) }

  it { should be_valid } 
end
