# == Schema Information
#
# Table name: mailboxes
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  name          :string(255)
#  host          :string(255)
#  port          :string(255)
#  ssl           :boolean
#  domain        :string(255)
#  username      :string(255)
#  passcode      :string(255)
#  starttls_auto :boolean
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'spec_helper'

describe Mailbox do
  before(:each) do
    @mailbox = FactoryGirl.build(:mailbox)
  end

  it { should belong_to(:user) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:host) }
  it { should validate_presence_of(:username) }
end
