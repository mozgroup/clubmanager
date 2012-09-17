# == Schema Information
#
# Table name: envelopes
#
#  id           :integer          not null, primary key
#  message_id   :integer
#  recipient_id :integer
#  read_flag    :boolean          default(FALSE)
#  trash_flag   :boolean          default(FALSE)
#  delete_flag  :boolean          default(FALSE)
#  delivered_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
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
end
