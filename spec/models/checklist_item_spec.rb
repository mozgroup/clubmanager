# == Schema Information
#
# Table name: checklist_items
#
#  id           :integer          not null, primary key
#  checklist_id :integer
#  name         :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'spec_helper'

describe ChecklistItem do

  before do
    @checklist_item = FactoryGirl.build(:checklist_item)
  end

  subject { @checklist_item }

  it { should belong_to(:checklist) }
  it { should have_many(:completes) }
  it { should have_many(:attachments) }
  it { should have_one(:item_checklist) }

  it { should accept_nested_attributes_for :attachments }

  it { should delegate(:name).to(:checklist).with_prefix }

  describe 'scopes' do
    before :each do
      @checklist_item.save
      @checklist = @checklist_item.checklist
      @user = @checklist.user
      FactoryGirl.create(:checklist_item)
      @items = FactoryGirl.create_list(:checklist_item, 5, checklist: @checklist)
      @items.each { |item| item.completes.create }
      @complete = @checklist_item.completes.create
    end

    describe 'for_user' do
      it 'returns the checklist_items that belong to the given user' do
        @items << @checklist_item
        items_for_user = ChecklistItem.for_user(@user)
        @items.size.should eq(items_for_user.count)
        items_for_user.each { |item| @items.should include(item) }
      end
    end

    describe 'completes_for_today' do
      it 'returns todays complete items' do
        @complete.update_column(:created_at, 1.day.ago)
        ChecklistItem.completes_for_today.should eq(@items)
      end
    end

    describe 'completes_for_week' do
      it 'returns todays complete items' do
        @complete.update_column(:created_at, 1.week.ago)
        ChecklistItem.completes_for_week.should eq(@items)
      end
    end

    describe 'completes_for_month' do
      it 'returns todays complete items' do
        @complete.update_column(:created_at, 1.month.ago)
        ChecklistItem.completes_for_month.should eq(@items)
      end
    end

    describe 'with_day_of_week' do
      it 'returns checklist_items for the given day of the week' do
        @items << @checklist_item
        FactoryGirl.create(:checklist, days_of_week: %w(wednesday thursday))
        @checklist.update_attributes(days_of_week: %w(monday tuesday))
        items_for_dow = ChecklistItem.with_day_of_week('monday')
        @items.size.should eq(items_for_dow.count)
        items_for_dow.each { |item| @items.should include(item) }
      end
    end

    describe 'daily' do
      it 'should return checklist_items for the current day' do
        @items << @checklist_item
        cl = FactoryGirl.create(:checklist, days_of_week: [Checklist::DAYS_OF_WEEK[(Time.zone.now+1.day).wday]])
        FactoryGirl.create(:checklist_item, checklist: cl)
        @checklist.update_attributes(days_of_week: [Checklist::DAYS_OF_WEEK[Time.zone.now.wday]])
        daily = ChecklistItem.daily
        @items.size.should eq(daily.count)
        daily.each { |item| @items.should include(item) }
      end
    end

    describe 'weekly' do
      it 'should return checklist_items that are weekly' do
        @items << @checklist_item
        @checklist.update_attributes(frequency: 'weekly')
        weekly = ChecklistItem.weekly
        @items.size.should eq(weekly.count)
        weekly.each { |item| @items.should include(item) }
      end
    end

    describe 'monthly' do
      it 'should return checklist_items that are monthly' do
        @items << @checklist_item
        @checklist.update_attributes(frequency: 'monthly')
        monthly = ChecklistItem.monthly
        @items.size.should eq(monthly.count)
        monthly.each { |item| @items.should include(item) }
      end
    end
  end

  describe 'is_complete? method' do
    before :each do
      @checklist_item.save
      @checklist = @checklist_item.checklist
    end

    it 'is daily and returns false' do
      @checklist_item.is_complete?(Time.zone.now).should be_false
    end

    it 'is weekly and returns false' do
      @checklist.update_column(:frequency, 'weekly')
      @checklist_item.is_complete?(Time.zone.now).should be_false
    end

    it 'is monthly and returns false' do
      @checklist.update_column(:frequency, 'monthly')
      @checklist_item.is_complete?(Time.zone.now).should be_false
    end

    it 'is daily and returns true' do
      @checklist_item.completes.create
      @checklist_item.is_complete?(Time.zone.now).should be_true
    end

    it 'is weekly and returns true' do
      @checklist.update_column(:frequency, 'weekly')
      @checklist_item.completes.create
      @checklist_item.is_complete?(Time.zone.now).should be_true
    end

    it 'is monthly and returns true' do
      @checklist.update_column(:frequency, 'monthly')
      @checklist_item.completes.create
      @checklist_item.is_complete?(Time.zone.now).should be_true
    end
  end

  describe 'complete method' do
    it 'marks the checklist_item complete' do
      @checklist_item.save
      @checklist_item.complete
      @checklist_item.completes.should_not be_empty
    end
  end

  describe 'undo_complete method' do
    it 'removes the checklist_item complete' do
      @checklist_item.save
      @checklist_item.complete
      @checklist_item.completes.should_not be_empty
      @checklist_item.undo_complete
      @checklist_item.completes.should be_empty
    end
  end

  describe 'has_attachments? method' do
    before(:each) { @checklist_item.save }

    it 'returns false' do
      @checklist_item.has_attachments?.should be_false
    end

    it 'returns true' do
      @checklist_item.attachments.create
      @checklist_item.has_attachments?.should be_true
    end
  end

  describe 'has_checklist? method' do
    before(:each) { @checklist_item.save }

    it { should_not have_checklist }

    it 'should have a checklist' do
      checklist = FactoryGirl.create(:checklist, checklist_item_id: @checklist_item.id)
      @checklist_item.should have_checklist
    end
  end

end
