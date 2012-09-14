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
  before do 
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
        @message.send_to = ""
        @message.copy_to = ""
        @message.blind_copy_to = ""
        @message.save
      end

      it "should raise and exception" do
        expect { @message.deliver }.to raise_error(Exceptions::NoRecipients)
      end
      its(:sent_at) { should be_nil }
      its(:envelopes) { should be_empty }
    end
  end
end
