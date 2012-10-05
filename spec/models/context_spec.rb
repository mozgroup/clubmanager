# == Schema Information
#
# Table name: contexts
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  position   :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Context do
  it { should belong_to(:owner) }
  it { should have_many(:projects) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }

  describe 'by_name scope' do
    it "should return an ordered list" do
      names = %w[ZZZ AAA GGG]
      names.each do |name|
        FactoryGirl.create(:context, name: name)
      end
      names.sort!
      contexts = Context.by_name
      contexts.each_index do |i|
        contexts[i].name.should eq(names[i])
      end
    end
  end

  describe 'Owner name' do
    before do
      @context = FactoryGirl.create(:context)
      @owner = @context.owner
    end
    subject { @context }
    its(:owner_full_name) { should == @owner.full_name }
  end
end
