# == Schema Information
#
# Table name: envelopes
#
#  id           :integer          not null, primary key
#  message_id   :integer
#  recipient_id :integer
#  read_flag    :boolean
#  trash_flag   :boolean
#  delete_flag  :boolean
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'spec_helper'

describe Envelope do

  it { should belong_to(:message) }
  it { should belong_to(:recipient) }

  before(:each) do
    @author = FactoryGirl.create(:user)
    @send_to = FactoryGirl.create(:user)
  end

  describe "belongs_to_user scope" do

    before do
      2.times do |i|
        @message = FactoryGirl.create(:message, author: @author, send_to: @send_to.full_name)
        @message.deliver
      end
    end

    it "should return the users envelopes" do
      Envelope.belongs_to_user(@send_to).count.should == 2
    end
  end

  describe "inbox scope" do

    before do
      2.times do |i|
        @message = FactoryGirl.create(:message, author: @author, send_to: @send_to.full_name)
        @message.deliver
        @message.envelopes[0].toggle!(:trash_flag) if i == 1
      end
    end

    it "should return envelopes with the trash flas = false" do
      Envelope.inbox.count.should == 1
    end
  end

end
