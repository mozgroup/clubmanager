# == Schema Information
#
# Table name: messages
#
#  id                   :integer          not null, primary key
#  author_id            :integer
#  send_to              :string(255)
#  copy_to              :string(255)
#  blind_copy_to        :string(255)
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

      before(:each) do
        @recip1 = FactoryGirl.create(:user, first_name: "Jane", last_name: "Doe")
        @recip2 = FactoryGirl.create(:user, first_name: "Bob", last_name: "Jones")
        @recip3 = FactoryGirl.create
        @message.send_to = "Jane Doe"
        @message.deliver
      end

      describe "send the message without first saving" do
        before do
          @message.send_to = "Jane Doe"
           @message.deliver
        end
        it { should_not be_new_record } 
      end

      describe "with one send_to recipient" do
        before do
        end

        its(:envelopes) { should_not be_empty }
  #     @message.envelopes.size.should == 1
  #     @message.envelopes[0].recipient.should == @user
      end
    end
  end

end
