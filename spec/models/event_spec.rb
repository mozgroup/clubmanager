# == Schema Information
#
# Table name: events
#
#  id             :integer          not null, primary key
#  organizer_id   :integer
#  summary        :text
#  description    :text
#  starts_at_time :time
#  starts_at_date :date
#  ends_at_date   :date
#

require 'spec_helper'

describe Event do

  it { should validate_presence_of(:summary) }
  it { should validate_presence_of(:starts_at_date) }

  it { should belong_to(:organizer) }
  it { should have_many(:subscriptions) }
  it { should have_many(:subscribers).through(:subscriptions) }

  before(:each) do
    @event = FactoryGirl.create(:event)
    @user = @event.organizer
  end

  subject { @event }

  it { should be_valid }

  describe "Organizer" do
    its(:organizer_full_name) { should == @user.full_name }

    it "should be subscribed to the event" do
      @event.subscribers.should(include(@user))
    end
  end

  describe 'is_subscriber? method' do
    it 'should return true' do
      @event.is_subscriber?(@user).should be(true)
    end
  end

  describe 'subscribed_to scope' do
    before do
      @event_list = [@event]
      4.times do |i|
        event = FactoryGirl.create(:event)
        event.subscribers << @user
        @event_list << event
      end
      @events = Event.subscribed_to(@user)
    end

    it 'should have the same number of subscribers' do
      @events.length.should eq(@event_list.length)
    end

    it 'should return all events for a user' do
      @events.each { |e| @event_list.should(include(e)) }
    end
  end

  describe 'for_month scope' do
    before(:each) do
      @first_of_month = FactoryGirl.create(:event, starts_at_date: Date.today.beginning_of_month)
      @end_of_month =  FactoryGirl.create(:event, starts_at_date: Date.today.end_of_month)
      @next_month = FactoryGirl.create(:event, starts_at_date: (Date.today.end_of_month + 1.day))
      @previous_month = FactoryGirl.create(:event, starts_at_date: (Date.today.beginning_of_month - 1.day))
      @event.update_column('starts_at_date', Date.today)
      @event_list = [@first_of_month, @event, @end_of_month]
      @events = Event.for_month(Date.today)
    end

    it 'should have the same number of events' do
      @events.length.should eq(@event_list.length)
    end

    it 'should return all events for the month' do
      @events.each { |e| @event_list.should(include(e)) }
    end
  end

  describe 'for_week scope' do
    before(:each) do
      @first_of_week = FactoryGirl.create(:event, starts_at_date: Date.today.beginning_of_week(:sunday))
      @end_of_week =  FactoryGirl.create(:event, starts_at_date: Date.today.end_of_week(:sunday))
      @next_week = FactoryGirl.create(:event, starts_at_date: (Date.today.end_of_week(:sunday) + 1.day))
      @previous_week = FactoryGirl.create(:event, starts_at_date: (Date.today.beginning_of_week(:sunday) - 1.day))
      @event.update_column('starts_at_date', Date.today)
      @event_list = [@first_of_week, @event, @end_of_week]
      @events = Event.for_week(Date.today)
    end

    it 'should have the same number of events' do
      @events.length.should eq(@event_list.length)
    end

    it 'should return all events for the week' do
      @events.each { |e| @event_list.should(include(e)) }
    end
  end

#  describe "for_week method" do
#    before do
#      @current_date = Time.now
#      @event_bow = FactoryGirl.create(:event, start_at: @current_date.at_beginning_of_week(:sunday))
#      @event_mow = FactoryGirl.create(:event, start_at: @current_date.at_beginning_of_week(:sunday) + 2.days)
#      @event_eow = FactoryGirl.create(:event, start_at: @current_date.at_end_of_week(:sunday))
#      FactoryGirl.create_list(:event, 3, start_at: 1.month.from_now)
#    end
#
#    it "should return only this weeks events" do
#      @events = Event.for_week(@current_date)
#      @events.size.should == 3
#    end
#
#    it "should have the same events in its result set" do
#      @events = Event.for_week(@current_date)
#      @events.each { |event| [@event_bow, @event_mow, @event_eow].should include(event) }
#    end
#  end
end
