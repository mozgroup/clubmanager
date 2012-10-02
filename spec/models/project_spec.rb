# == Schema Information
#
# Table name: projects
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  user_id     :integer
#  position    :integer
#  context_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'spec_helper'

describe Project do
  before(:each) do
    @project = FactoryGirl.build(:project)
  end

  subject { @project }

  it { should belong_to(:owner) }
  it { should belong_to(:context) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }

  it { should be_valid }
end
