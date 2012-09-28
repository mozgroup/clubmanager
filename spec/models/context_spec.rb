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
  before(:each) do
    @context = FactoryGirl.create(:context)
  end

  subject { @context }

  it { should belong_to(:user) }
  it { should have_many(:projects) }
  it { should validate_presence_of(:name) }
end
