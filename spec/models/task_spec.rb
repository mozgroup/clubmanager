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
#  assignee_id  :integer
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
  it { should respond_to(:context_name) }
  it { should respond_to(:project_name) }

  it { should be_valid }

  describe "Owner full name" do
    before do
      @task.save!
      @owner = @task.owner
    end
    its(:owner_full_name) { should == @owner.full_name }
  end

  describe "Project name" do
    it "should return the name" do
      @task.save!
      @task.project_name.should eq(@task.project.name)
    end

    it "should return nil if new" do
      task = FactoryGirl.build(:task, project: nil)
      task.project_name.should be_nil
    end
  end

  describe "Context name" do
    it "should return the name" do
      @task.save!
      @task.context_name.should eq(@task.context.name)
    end

    it "should return nil if new" do
      task = FactoryGirl.build(:task, context: nil)
      task.context_name.should be_nil
    end
  end

  describe "context_name= method" do
    describe "with an existing context" do
      it "should assign it to the task" do
        context = FactoryGirl.create(:context)
        @task.context_name = context.name
        @task.save!
        @task.context.should eq(context)
      end
    end

    describe "when the context does not exist" do
      it "should create a new context" do
        @task.context_name = "foo"
        @task.save!
        @task.context.name.should eq("foo")
      end
    end
  end

  describe "project_name=" do
    describe "with an existing project" do
      it "should assign it to the task" do
        project = FactoryGirl.create(:project)
        @task.project_name = project.name
        @task.save!
        @task.project.should eq(project)
      end
    end

    describe "when the project does not exist" do
      it "should create a new context" do
        @task.project_name = "foo"
        @task.save!
        @task.project.name.should eq("foo")
        @task.context.should eq(@task.project.context)
      end
    end
  end
end
