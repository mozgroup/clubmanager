require 'spec_helper'

describe Notifier do

  describe "initialize" do

    it "should setup message params" do
      notifier = Notifier.new({to: 'foo', from: 'bar', subject: 'message from bar', body: 'This is the body'})
      notifier.instance_variable_get(:@to).should eq('foo')
      notifier.instance_variable_get(:@from).should eq('bar')
      notifier.instance_variable_get(:@subject).should eq('message from bar')
      notifier.instance_variable_get(:@body).should eq('This is the body')
    end

    it "should setup blank params if none are supplied" do
      notifier = Notifier.new
      notifier.instance_variable_get(:@to).should be_blank
      notifier.instance_variable_get(:@from).should be_blank
      notifier.instance_variable_get(:@subject).should be_blank
      notifier.instance_variable_get(:@body).should be_blank
    end

    it "should allow params to be set" do
      notifier = Notifier.new
      notifier.to = 'foo'
      notifier.from = 'bar'
      notifier.subject = 'subject'
      notifier.body = 'body'
    end

    it "should allow 1 param to be set" do
      notifier = Notifier.new(to: 'foo')
    end

    it "should read config file" do
      notifier = Notifier.new
      notifier.instance_variable_get(:@message_params).class.should eq(Hash)
    end
  end

  context "calling methods" do

    describe "deliver_a_message call" do
      it "should attempt to create a_message notification" do
        expect do
          Notifier.new().deliver_a_message
        end.to_not raise_error(NoMethodError)
      end
    end
    
    describe "a_message call" do
      it "should raise an exception because method is malformed" do
        expect do
          Notifier.new().a_message
        end.to raise_error(NoMethodError)
      end
    end
  end
end
