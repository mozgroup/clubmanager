# == Schema Information
#
# Table name: envelopes
#
#  id             :integer          not null, primary key
#  message_id     :integer
#  recipient_id   :integer
#  read_flag      :boolean          default(FALSE)
#  important_flag :boolean          default(FALSE)
#  trash_flag     :boolean          default(FALSE)
#  delete_flag    :boolean          default(FALSE)
#  delivered_at   :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  author_flag    :boolean          default(FALSE)
#

require 'spec_helper'

describe Envelope do

  before(:each) do
    @user = FactoryGirl.create(:user)
    @message = FactoryGirl.create(:message, author: @user)
    @envelope = FactoryGirl.create(:envelope, message: @message)
  end

  subject { @envelope }

  it { should belong_to(:message) }
  it { should belong_to(:recipient) }

  describe 'sender method' do
    it "should return senders full name" do
      @envelope.sender_full_name.should == @user.full_name
    end
  end

  describe "is_read? method" do
    before { @envelope.toggle!(:read_flag) }
    it "should return true" do
      @envelope.is_read?.should be_true
    end
  end

  describe "is_important? method" do
    before { @message.update_attribute('importance', Message::Important) }
    it "should return true" do
      @envelope.is_important?.should be_true
    end
  end

  describe "is_trash? method" do
    before { @envelope.toggle!(:trash_flag) }
    it "should return true" do
      @envelope.is_trash?.should be_true
    end
  end

  describe "trash method" do
    before { @envelope.trash }
    it "should make the trash flag true" do
      @envelope.trash_flag.should be_true
    end
  end

  describe "delete method" do
    before { @envelope.delete_it }
    it "should make the delete flag true" do
      @envelope.delete_flag.should be_true
    end
  end

  describe "mark_important method" do
    before { @envelope.mark_important }
    it "should make the infortant_flag true" do
      @envelope.important_flag.should be_true
    end
  end
end
