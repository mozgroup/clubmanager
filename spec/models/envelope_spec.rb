# == Schema Information
#
# Table name: envelopes
#
#  id           :integer          not null, primary key
#  message_id   :integer
#  recipient_id :integer
#  read_flag    :boolean
#  trash_flag   :boolean
#  delete_flag  :boolean
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'spec_helper'

describe Envelope do
  it { should belong_to(:message) }
  it { should belong_to(:recipient) }
end
