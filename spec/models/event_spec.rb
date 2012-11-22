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
#

require 'spec_helper'

describe Event do
  before(:each) do
    @event = FactoryGirl.build(:event)
  end

  subject { @event }

  it { should belong_to(:user) }

  it { should validate_presence_of(:subject) }
  it { should validate_presence_of(:start_at) }
  it { should validate_presence_of(:end_at) }

  it { should be_valid }

  describe "User full name" do
    before do
      @event.save!
      @user = @event.user
    end
    its(:user_full_name) { should == @user.full_name }
  end

end
