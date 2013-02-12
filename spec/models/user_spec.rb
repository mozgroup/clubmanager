# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  failed_attempts        :integer          default(0)
#  locked_at              :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  employee_number        :string(255)
#  title                  :string(255)
#  first_name             :string(255)
#  last_name              :string(255)
#  roles_mask             :integer
#

require 'spec_helper'

describe User do

  before(:each) do
    @attr = {
      :first_name => "Example",
      :last_name => "User",
      :email => "user@example.com",
      :password => "foobar",
      :password_confirmation => "foobar",
      :employee_number => "1"
    }
  end

  it { should have_many(:clubs).through(:club_users) }
  it { should have_many(:messages).through(:envelopes) }
  it { should have_many(:authored_messages) }
  it { should have_many(:projects) }
  it { should have_many(:contexts) }
  it { should have_many(:tasks) }
  it { should have_many(:mailboxes) }

  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:employee_number) }

  it "should create a new instance given a valid attribute" do
    User.create!(@attr)
  end

  it "should require an email address" do
    no_email_user = User.new(@attr.merge(:email => ""))
    no_email_user.should_not be_valid
  end

  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end

  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_user = User.new(@attr.merge(:email => address))
      invalid_email_user.should_not be_valid
    end
  end

  it "should reject duplicate email addresses" do
    User.create!(@attr)
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end

  it "should reject email addresses identical up to case" do
    upcased_email = @attr[:email].upcase
    User.create!(@attr.merge(:email => upcased_email))
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end

  describe "passwords" do

    before(:each) do
      @user = User.new(@attr)
    end

    it "should have a password attribute" do
      @user.should respond_to(:password)
    end

    it "should have a password confirmation attribute" do
      @user.should respond_to(:password_confirmation)
    end
  end

  describe "password validations" do

    it "should require a password" do
      User.new(@attr.merge(:password => "", :password_confirmation => "")).
        should_not be_valid
    end

    it "should require a matching password confirmation" do
      User.new(@attr.merge(:password_confirmation => "invalid")).
        should_not be_valid
    end

    it "should reject short passwords" do
      short = "a" * 5
      hash = @attr.merge(:password => short, :password_confirmation => short)
      User.new(hash).should_not be_valid
    end

  end

  describe "password encryption" do

    before(:each) do
      @user = User.create!(@attr)
    end

    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end

    it "should set the encrypted password attribute" do
      @user.encrypted_password.should_not be_blank
    end

  end

  describe "envelope association" do

    before { @user = User.create!(@attr) }
    let!(:older_envelope) do
      FactoryGirl.create(:week_ago_envelope, recipient: @user)
    end
    let!(:newer_envelope) do
      FactoryGirl.create(:hour_ago_envelope, recipient: @user)
    end
    let!(:trashed_envelope) do
      FactoryGirl.create(:day_ago_trashed_envelope, recipient: @user)
    end

    it "should have right envelopes in the right order" do
      @user.envelopes.should == [newer_envelope, trashed_envelope, older_envelope]
    end

    it "should only have non trashed envelopes" do
      @user.envelopes.inbox.should == [newer_envelope, older_envelope]
    end

    it "should get the count of the unread envelopes" do
      @user.envelopes.unread_count.should == 2
    end

    it "should return the trashed envelopes" do
      @user.envelopes.trash.should == [trashed_envelope]
    end
  end

  describe "authored_message association" do

    before { @user = User.create!(@attr) }
    let!(:older_sent_message) do
      FactoryGirl.create(:sent_a_week_ago, author: @user)
    end
    let!(:older_draft_message) do
      FactoryGirl.create(:message, author: @user, created_at: 1.day.ago)
    end
    let!(:sent_message) do
      FactoryGirl.create(:sent_an_hour_ago, author: @user)
    end
    let!(:draft_message) do
      FactoryGirl.create(:message, author: @user)
    end

    it "should return the sent messages in the right order" do
      @user.authored_messages.sent.should == [sent_message, older_sent_message]
    end

    it "should return the draft messages in the right order" do
      @user.authored_messages.drafts.should == [draft_message, older_draft_message]
    end
  end

  describe "name_search class method" do

    let!(:user1) { FactoryGirl.create(:user, first_name: 'Marvin', last_name: 'Wilson') }
    let!(:user2) { FactoryGirl.create(:user, first_name: 'George', last_name: 'Washington') }
    let!(:user3) { FactoryGirl.create(:user, first_name: 'Gracie', last_name: 'Martin') }

    it "should return 2 users" do
      users = User.name_search('ar')
      users.should == [user1, user3]
    end
  end

  # Make sure the logging mixin has been added
  it { should have_many(:sys_logs).dependent(:destroy) }
  it "should add a log item" do
    user = User.create!(@attr)
    log = user.log_created("This is a test", "Tester")
    log.message_type.should eq("CREATED")
    log.message.should eq("This is a test")
    log.actioned_by.should eq("Tester")
  end

  describe "events association" do

    it { should have_many(:subscriptions) }
    it { should have_many(:events).through(:subscriptions) }
    it { should have_many(:organized_events) }

#    describe "events_for extension" do
#
#      let!(:user) { FactoryGirl.create(:user) }
#      let!(:current_date) { Time.parse('20121115') }
#      let!(:prev_month) { FactoryGirl.create(:event, organizer: user, start_at: current_date - 1.month, end_at: current_date - 1.month) }
#      let!(:next_month) { FactoryGirl.create(:event, organizer: user, start_at: current_date + 1.month, end_at: current_date + 1.month) }
#      let!(:event1) { FactoryGirl.create(:event, organizer: user, start_at: current_date.at_beginning_of_month, end_at: current_date.at_beginning_of_month) }
#      let!(:event2) { FactoryGirl.create(:event, organizer: user, start_at: current_date - 1.days, end_at: current_date - 1.days) }
#      let!(:event3) { FactoryGirl.create(:event, organizer: user, start_at: current_date + 1.days, end_at: current_date + 1.days) }
#      let!(:event4) { FactoryGirl.create(:event, organizer: user, start_at: current_date.at_end_of_month, end_at: current_date.at_end_of_month) }
#
#      it "should return only the current months events" do
#        Event.all.each { |event| event.users << user }
#
#        events =  user.events.for_month(current_date)
#        events.size.should eq(4)
#        events.each do |event|
#          [event1, event2, event3, event4].should include(event)
#        end
#      end
#    end
  end
end
