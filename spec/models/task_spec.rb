# == Schema Information
#
# Table name: tasks
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  due_at       :datetime
#  completed_at :datetime
#  context_id   :integer
#  project_id   :integer
#  owner_id     :integer
#  notes        :text
#  state        :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'spec_helper'

describe Task do
  before(:each) do
    @task = FactoryGirl.build(:task)
  end

  subject { @task }

  it { should belong_to(:context) }
  it { should belong_to(:project) }
  it { should belong_to(:owner) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:due_at) }

  it { should be_valid }
end
