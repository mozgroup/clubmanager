# == Schema Information
#
# Table name: messages
#
#  id                   :integer          not null, primary key
#  author_id            :integer
#  send_to              :string(255)      default("")
#  copy_to              :string(255)      default("")
#  blind_copy_to        :string(255)      default("")
#  subject              :string(255)
#  body                 :text
#  status               :string(255)      default("draft")
#  importance           :string(255)      default("normal")
#  sent_at              :datetime
#  read_receipt_request :boolean          default(FALSE)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

require 'spec_helper'

describe Message do
  before(:each) do
    @message = FactoryGirl.build(:message)
  end

  subject { @message }

  it { should respond_to(:author_id) }
  it { should respond_to(:send_to) }
  it { should respond_to(:copy_to) }
  it { should respond_to(:blind_copy_to) }
  it { should respond_to(:subject) }
  it { should respond_to(:body) }
  it { should respond_to(:status) }
  it { should respond_to(:importance) }
  it { should respond_to(:sent_at) }
  it { should respond_to(:read_receipt_request) }

  it { should belong_to(:author) }

  it { should be_valid }

  describe "Author name" do
    before do
      @message.save!
      @author = @message.author
    end
    its(:author_full_name) { should == @author.full_name }
  end

  describe "default message values" do
    before do
      @message.save!
    end

    its(:status) { should == "draft" }
    its(:importance) { should == "normal" }
  end

  describe 'belonging_to scope' do
    before do
      @message.save!
      @user = FactoryGirl.create(:user)
      @messages = FactoryGirl.create_list(:message, 10, author: @user)
    end

    it "has the same number of messages" do
      @user_messages = Message.belonging_to(@user)
      @user_messages.size.should eq(@messages.size)
    end

    it { Message.belonging_to(@user).count.should eq(@messages.size) }
    it { Message.belonging_to(@user).each { |m| @messages.should include(m) } }
  end

  describe 'drafts scope' do
    before do
      @messages = FactoryGirl.create_list(:message, 10)
      FactoryGirl.create(:message, status: 'sent')
    end

    it { Message.drafts.count.should eq(@messages.size) }
    it { Message.drafts.each { |m| @messages.should include(m) } }
  end

  describe 'sent scope' do
    before do
      @messages = FactoryGirl.create_list(:message, 10, status: Message::StatusSent)
      FactoryGirl.create(:message)
    end

    it { Message.sent.count.should eq(@messages.size) }
    it { Message.sent.each { |m| @messages.should include(m) } }
  end

  describe 'trash scope' do
    before do
      @messages = FactoryGirl.create_list(:message, 10, status: Message::StatusTrash)
      FactoryGirl.create(:message)
    end

    it { Message.trash.count.should eq(@messages.size) }
    it { Message.trash.each { |m| @messages.should include(m) } }
  end

#  describe "delivery of message" do
#    it { should respond_to(:deliver) }
#
#    describe "with no recipients" do
#      before do
#        @message.save
#      end
#
#      it "should raise and exception" do
#        expect { @message.deliver }.to raise_error(Exceptions::NoRecipients)
#      end
#      its(:sent_at) { should be_nil }
#      its(:envelopes) { should be_empty }
#    end
#
#    describe "with one or more recipients" do
#
#      let!(:recip1) do
#        FactoryGirl.create(:user)
#      end
#      let!(:recip2) do
#        FactoryGirl.create(:user)
#      end
#      let!(:recip3) do
#        FactoryGirl.create(:user)
#      end
#
#      before do
#        @message.send_to = recip1.full_name
#        @message.copy_to = recip2.full_name
#        @message.blind_copy_to = recip3.full_name
#        @message.deliver
#        @env_recips = []
#        @message.envelopes.each do |envelope|
#          @env_recips << envelope.recipient
#        end
#      end
#
#      it { should_not be_new_record }
#      it "should have envelopes for all recipients" do
#        [recip1, recip2, recip3].each do |recip|
#          @env_recips.should include(recip)
#        end
#      end
#
#      it "should have an envelope for the author" do
#        @env_recips.should include(@message.author)
#      end
#
#      its(:envelopes) { should_not be_empty }
#      its(:status) { should == Message::StatusSent }
#      its(:sent_at) { should_not be_nil }
#    end
#  end
#
#  describe "envelopes association" do
#    before(:each) do
#      @send_to = FactoryGirl.create(:user)
#      @message.send_to = @send_to.full_name
#      @message.deliver
#    end
#
#    it "should return the current users envelope and mark it read" do
#      envelope = @message.envelopes.current_envelope(@send_to)
#      envelope.recipient.should == @send_to
#      envelope.is_read?.should be_true
#    end
#  end

end
