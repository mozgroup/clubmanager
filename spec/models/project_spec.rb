# == Schema Information
#
# Table name: projects
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  owner_id    :integer
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
  it { should have_many(:tasks) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }

  it { should be_valid }

  describe "Context name" do
    before do
      @project.save!
      @context = @project.context
    end
    its(:context_name) { should == @context.name }
  end

  describe "Context name without a context" do
    before do
      @project.context = nil
      @project.save!
    end
    its(:context_name) { should be_nil }
  end

  describe "Owner name" do
    before do
      @project.save!
      @owner = @project.owner
    end
    its(:owner_full_name) { should == @owner.full_name }
  end
end
