require 'spec_helper'

describe Notifier::Tasks do

  describe "reading the config file" do
    describe "the filepath" do
      it "should generate the path to the task notifier config file" do
        Notifier::Tasks.config.should_not be_blank
      end
    end
  end

  context "Invalid methods are invoked" do
    describe "when method is called without deliver_" do
      it "shoud raise a NoMethodError" do
        expect do
          Notifier::Tasks.some_notifier
        end.to raise_error(NoMethodError)
      end
    end
  end

  context "Valid methods are invoked" do

    let!(:user) { FactoryGirl.create(:user) }
    let!(:assignee) { FactoryGirl.create(:user) }
    let!(:task) { FactoryGirl.create(:task, owner: user) }

    before { task.update_column('assignee_id', assignee.id) }

    describe "when a method is called with deliver_" do
      it "should not raise NoMethodError" do
        expect do
          Notifier::Tasks.deliver_some_valid_notifier(task)
        end.to_not raise_error(NoMethodError)
      end
    end

    describe "when deliver_some_valid_notifier is called" do
      it "should send a message to the task assignee" do
        Notifier::Tasks.deliver_some_valid_notifier(task)
        user.messages.should_not be_empty
      end
    end
  end

end
