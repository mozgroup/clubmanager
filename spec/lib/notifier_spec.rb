require 'spec_helper'

describe Notifier::Tasks do

  context "class methods" do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:assignee) { FactoryGirl.create(:user) }
    let!(:task) { FactoryGirl.create(:task, owner: user) }

    before(:each) { task.update_column('assignee_id', assignee.id) }

    describe "when assigned_task_message is invoked" do
      before { Notifier::Tasks.deliver_assigned_task_message(task) }

      it "should send a message to the assignee" do
        task.assignee.messages.should_not be_empty
      end

      it "should have the owner as the author of the message" do
        task.owner.authored_messages.should_not be_empty
      end
    end

    describe "when claim_task_message is invoked" do
      before { Notifier::Tasks.deliver_claim_task_message(task) }

      it "should send a message to the owner" do
        task.owner.messages.should_not be_empty
      end

      it "should have the assignee as the author of the message" do
        task.assignee.authored_messages.should_not be_empty
      end
    end

    describe "when completed_task_message is invoked" do
      before { Notifier::Tasks.deliver_completed_task_message(task) }

      it "should send a message to the owner" do
        task.owner.messages.should_not be_empty
      end

      it "should have the assignee as the author of the message" do
        task.assignee.authored_messages.should_not be_empty
      end
    end
  end

end
