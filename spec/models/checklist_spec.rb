# == Schema Information
#
# Table name: checklists
#
#  id                :integer          not null, primary key
#  user_id           :integer
#  author_id         :integer
#  name              :string(255)
#  frequency         :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  days_of_week_mask :integer
#  checklist_item_id :integer
#

require 'spec_helper'

describe Checklist do

  before do
    @checklist = FactoryGirl.build(:checklist)
  end

  subject { @checklist }

  it { should belong_to(:user) }
  it { should belong_to(:author) }
  it { should have_many(:checklist_items) }
  it { should belong_to(:checklist_item) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:frequency) }

  it { should delegate(:full_name).to(:user).with_prefix }
  it { should delegate(:full_name).to(:author).with_prefix }

  it { should accept_nested_attributes_for :checklist_items }

  describe 'with_day_of_week scope' do
    before do
      checklist1 = FactoryGirl.create(:checklist, days_of_week: ['monday'])
      checklist2 = FactoryGirl.create(:checklist, days_of_week: ['monday','wednesday'])
      checklist3 = FactoryGirl.create(:checklist, days_of_week: ['tuesday','wednesday','thursday'])
      @test_days = [checklist1, checklist2]
      @results = Checklist.with_day_of_week('monday')
    end
    it { @results.each { |result| @test_days.should include(result) } }
  end

  describe 'for_user scope' do
    before do
      @checklist.save
      user = @checklist.user
      checklist1 = FactoryGirl.create(:checklist, user: user)
      checklist2 = FactoryGirl.create(:checklist, user: user)
      checklist3 = FactoryGirl.create(:checklist)
      @test_days = [@checklist, checklist1, checklist2]
      @results = Checklist.for_user user
    end
    it { @results.each { |result| @test_days.should include(result) } }
  end

  describe 'without_parent scope' do
    before do
      @checklist.save
      @checklist1 = FactoryGirl.create(:checklist_child)
      @checklist2 = @checklist1.checklist_item.checklist
    end

    it { Checklist.without_parent.should == [@checklist, @checklist2] }
    it { Checklist.without_parent.should_not include(@checklist1) }
  end

  describe 'assigned_to method' do
    its(:assigned_to) { should == @checklist.user_full_name }
  end

  describe 'assigned_to= method' do
    before { @checklist.save }

    it 'assigns a new user' do
      user = FactoryGirl.create(:user)
      @checklist.assigned_to = user.full_name
      @checklist.user_full_name.should == user.full_name
    end

    it 'should not assign a new user because user is not found' do
      user = @checklist.user
      @checklist.assigned_to = 'no name'
      @checklist.user_full_name.should == user.full_name
    end
  end

  describe 'is_daily? method' do
    it { @checklist.is_daily?.should be_true }
    it 'returns false' do
      @checklist.frequency = 'monthly'
      @checklist.is_daily?.should_not be_true
    end
  end

  describe 'is_weekly? method' do
    it { @checklist.is_weekly?.should_not be_true }
    it 'returns true' do
      @checklist.frequency = 'weekly'
      @checklist.is_weekly?.should be_true
    end
  end

  describe 'is_monthly? method' do
    it { @checklist.is_monthly?.should_not be_true }
    it 'returns true' do
      @checklist.frequency = 'monthly'
      @checklist.is_monthly?.should be_true
    end
  end

  describe 'days_of_week= method' do
    it 'should set days_of_week mask to the appropriate value' do
      days_of_week = %w(sunday monday tuesday wednesday thursday friday saturday)
      days_of_week.each do |dow|
        @checklist.days_of_week = [dow]
        @checklist.days_of_week_mask.should == 2**days_of_week.index(dow)
      end
    end
    it 'should set days_of_week_mask to appropriate value with multiple days' do
      days_of_week = %w(sunday thursday)
      @checklist.days_of_week = days_of_week
      @checklist.days_of_week_mask.should == days_of_week.map { |d| 2**Checklist::DAYS_OF_WEEK.index(d) }.sum
    end
  end

  describe 'days_of_week method' do
    it 'should return the days that are set' do
      days_of_week = %w(sunday wednesday friday)
      @checklist.days_of_week = days_of_week
      @checklist.days_of_week.should == days_of_week
    end
  end

  describe 'day_of_week method' do
    it 'should return the appropriate day of week' do
      days_of_week = %w(sunday monday tuesday wednesday thursday friday saturday)
      days_of_week.each { |d| @checklist.day_of_week(d).should == days_of_week.index(d) }
    end
  end

  describe 'has_parent? method' do
    before { @checklist.save }

    it { should_not have_parent }

    it 'should have a parent' do
      item = FactoryGirl.create(:checklist_item)
      @checklist.update_column(:checklist_item_id, item.id)
      @checklist.should have_parent
    end
  end
end
