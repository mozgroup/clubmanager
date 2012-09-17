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
  it { should have_many(:envelopes) }

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

  describe "delivery of message" do
    it { should respond_to(:deliver) }

    describe "with no recipients" do
      before do
        @message.save
      end

      it "should raise and exception" do
        expect { @message.deliver }.to raise_error(Exceptions::NoRecipients)
      end
      its(:sent_at) { should be_nil }
      its(:envelopes) { should be_empty }
    end

    describe "with one or more recipients" do

      let!(:recip1) do
        FactoryGirl.create(:user)
      end
      let!(:recip2) do
        FactoryGirl.create(:user)
      end
      let!(:recip3) do
        FactoryGirl.create(:user)
      end

      before do
        @message.send_to = recip1.full_name
        @message.copy_to = recip2.full_name
        @message.blind_copy_to = recip3.full_name
        @message.deliver
      end

      it { should_not be_new_record } 
      it "should have envelopes for all recipients" do
        env_recips = []
        @message.envelopes.each do |envelope|
          env_recips << envelope.recipient
        end
        [recip1, recip2, recip3].each do |recip|
          env_recips.should include(recip)
        end
      end

      its(:envelopes) { should_not be_empty }
      its(:status) { should == Message::StatusSent }
      its(:sent_at) { should_not be_nil }
    end
  end

  describe "current_envelope" do
    let!(:send_to) { FactoryGirl.create(:user) }
 
    before do
      @message.send_to = send_to.full_name
      @message.deliver
    end

    it "should return the current users envelope for this message" do
      envelope = @message.envelopes.current_envelope(send_to)[0]
      envelope.recipient.should == send_to
    end
  end

#  describe "mark_as_read method" do
#    let!(:send_to) { FactoryGirl.create(:user) }
#
#    before do
#      @message.send_to = send_to.full_name
#      @message.deliver
#    end
#
#    it "should return the users envelope and mark it as read" do
#
#    end
#
#  end

end
