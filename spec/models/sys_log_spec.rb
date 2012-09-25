# == Schema Information
#
# Table name: sys_logs
#
#  id            :integer          not null, primary key
#  message       :text
#  message_type  :string(255)
#  actioned_by   :string(255)
#  loggable_id   :integer
#  loggable_type :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'spec_helper'

describe SysLog do

  it { should belong_to(:loggable) }
  it { should allow_mass_assignment_of(:actioned_by) }
  it { should allow_mass_assignment_of(:message) }
  it { should allow_mass_assignment_of(:message_type) }
  it { should validate_presence_of(:actioned_by) }
  it { should validate_presence_of(:message) }
  it { should validate_presence_of(:message_type) }
end
