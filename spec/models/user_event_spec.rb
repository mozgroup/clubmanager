# == Schema Information
#
# Table name: user_events
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  event_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe UserEvent do

  describe "for_user method" do
    before do
      @user1 = FactoryGirl.create(:user)
      @user2 = FactoryGirl.create(:user)
      @events = FactoryGirl.create_list(:event, 3)
      @events.each { |event| event.users << @user1; event.users << @user2 }
    end

    it "should return 3 events" do
      UserEvent.for_user(@user1.id).count.should == 3
    end

    it "should return only the users user_events" do
      user_events = UserEvent.for_user(@user1.id)
      user_events.each { |ue| ue.user_id.should == @user1.id }
    end
  end

  describe "for_week method" do
    before do
      @current_date = Time.now
      user = FactoryGirl.create(:user)
      @event_bow = FactoryGirl.create(:event, start_at: @current_date.at_beginning_of_week(:sunday))
      @event_mow = FactoryGirl.create(:event, start_at: @current_date.at_beginning_of_week(:sunday) + 2.days)
      @event_eow = FactoryGirl.create(:event, start_at: @current_date.at_end_of_week(:sunday))
      FactoryGirl.create_list(:event, 3, start_at: 1.month.from_now)

      Event.all.each { |event| event.users << user }
    end

    it { UserEvent.for_week(@current_date).count.should == 3 }

    it "should return only entries in the date range" do
      user_events = UserEvent.for_week(@current_date)
      user_events.each { |ue| [@event_bow.id, @event_mow.id, @event_eow.id].should include(ue.event_id) }
    end

  end
end
