# == Schema Information
#
# Table name: events
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  invitee_list :string(255)
#  subject      :string(255)
#  location     :string(255)
#  description  :text
#  start_at     :datetime
#  end_at       :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  state        :string(255)
#

require 'spec_helper'

describe Event do
  before(:each) do
    @event = FactoryGirl.build(:event)
  end

  subject { @event }

  it { should belong_to(:organizer) }

  it { should validate_presence_of(:subject) }
  it { should validate_presence_of(:start_at) }
  it { should validate_presence_of(:end_at) }

  it { should be_valid }

  describe "User full name" do
    before do
      @event.save!
      @user = @event.organizer
    end
    its(:organizer_full_name) { should == @user.full_name }
  end

  describe "for_week method" do
    before do
      @current_date = Time.now
      @event_bow = FactoryGirl.create(:event, start_at: @current_date.at_beginning_of_week(:sunday))
      @event_mow = FactoryGirl.create(:event, start_at: @current_date.at_beginning_of_week(:sunday) + 2.days)
      @event_eow = FactoryGirl.create(:event, start_at: @current_date.at_end_of_week(:sunday))
      FactoryGirl.create_list(:event, 3, start_at: 1.month.from_now)
    end

    it "should return only this weeks events" do
      @events = Event.for_week(@current_date)
      @events.size.should == 3
    end

    it "should have the same events in its result set" do
      @events = Event.for_week(@current_date)
      @events.each { |event| [@event_bow, @event_mow, @event_eow].should include(event) }
    end
  end
end
