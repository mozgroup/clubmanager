# == Schema Information
#
# Table name: regions
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Region do
  before do
    @region = FactoryGirl.build(:region)
  end

  subject { @region }

  it { should respond_to(:name) }

  it { should allow_mass_assignment_of(:name) }

  it { should validate_presence_of(:name) }
  it { should have_many(:clubs) }

  it { should be_valid }
end
