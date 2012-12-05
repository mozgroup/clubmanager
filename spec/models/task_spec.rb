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
#  started_at   :datetime
#  claimed_at   :datetime
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
    its(:project_name) { should == @task.project.name }

    it "should return nil if new" do
      task = FactoryGirl.build(:task, project: nil)
      task.project_name.should be_nil
    end
  end

  describe "Context name" do
    its(:context_name) { should eq(@task.context.name) }

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
        @task.context.should eq(context)
      end
    end

    describe "when the context does not exist" do
      it "should create a new context" do
        @task.context_name = "foo"
        @task.context.name.should eq("foo")
      end
    end
  end

  describe "project_name=" do
    describe "with an existing project" do
      it "should assign it to the task" do
        project = FactoryGirl.create(:project)
        @task.project_name = project.name
        @task.project.should eq(project)
      end
    end

    describe "when the project does not exist" do
      it "should create a new project" do
        @task.project_name = "foo"
        @task.project.name.should eq("foo")
        @task.context.should eq(@task.project.context)
      end
    end
  end

  describe "assigned_to=" do
    it "should add user to the assignee" do
      user = FactoryGirl.create(:user)
      @task.assigned_to = user.full_name
      @task.assignee_id.should eq(user.id)
    end

    it "should not error if a blank name is supplied" do
      @task.assigned_to = ''
      @task.assignee_id.should be_nil
    end
  end

  describe "assigned_to" do
    it "should return the name of the person the task is assinged to" do
      user = FactoryGirl.create(:user)
      assigned_to = user.full_name
      assigned_to.should eq(user.full_name)
    end
  end

  describe "update_assigned_to" do
    before do
      @user =  FactoryGirl.create(:user)
      @task.update_assigned_to @user.full_name
    end

    its(:assigned_to) { should eq(@user.full_name) }
    its(:state) { should eq("assigned") }
    it { @task.assignee.messages.should_not be_empty }
  end

  describe "has_assignee? method" do
    it { should_not have_assignee }

    it "should return true" do
      assigned_task = FactoryGirl.create(:assigned_task)
      assigned_task.should have_assignee
    end
  end

  describe "claim_task method" do
    before do
      @task = FactoryGirl.create(:assigned_task)
      @task.claim_task
    end

    its(:state) { should == 'claimed' }

    it "should send a message to the owner" do
      @task.owner.messages.should_not be_empty
#      @task.owner.messages[0].send_to.should eq(@task.owner_full_name)
    end
  end

  describe "start_task method" do
    before do
      @task = FactoryGirl.create(:claimed_task)
      @task.start_task
    end

    its(:state) { should == 'started' }
  end

  describe "complete_task method" do
    before do
      @task = FactoryGirl.create(:started_task)
      @task.update_column('state', 'started')
      @task.complete_task
    end

    its(:state) { should == 'completed' }

    it "should send a message to the owner" do
      @task.owner.messages.should_not be_empty
#      @task.owner.messages[0].send_to.should eq(@task.owner_full_name)
    end

#    it "should contain the task name in the body" do
#      message = @started_task.owner.messages[0]
#      message.body.should include(@task.name)
#    end
  end

  describe "by_assigned_user method" do
    before do
      @assignee = FactoryGirl.create(:user)
      @task_list = FactoryGirl.create_list(:task, 10, assignee: @assignee)
      FactoryGirl.create_list(:task, 5)  # insert random tasks to make sure the method does not read them
    end

    it "should return all tasks assigned" do
      @tasks = Task.by_assigned_user(@assignee)
      @tasks.size.should == 10
    end
  end

  describe "for_week method" do
    before do
      @current_date = Time.now
      @task_bow = FactoryGirl.create(:task, @owner, due_at: @current_date.at_beginning_of_week(:sunday))
      @task_mow = FactoryGirl.create(:task, @owner, due_at: @current_date.at_beginning_of_week(:sunday) + 2.days)
      @task_eow = FactoryGirl.create(:task, @owner, due_at: @current_date.at_end_of_week(:sunday))
      FactoryGirl.create_list(:task, 3, due_at: 1.month.from_now)
    end

    it "should return only this weeks tasks" do
      @tasks = Task.for_week(@current_date)
      @tasks.size.should == 3
    end

    it "should return tasks that are due for the current week" do
      @tasks = Task.for_week(@current_date)
      @tasks.each { |task| [@task_bow, @task_mow, @task_eow].should include(task) }
    end
  end

end

