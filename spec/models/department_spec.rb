# == Schema Information
#
# Table name: departments
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'spec_helper'

describe Department do
  before do
    @department = FactoryGirl.build(:department)
  end

  it { should validate_presence_of(:name) }

  it { should have_many(:tasks) }

end
