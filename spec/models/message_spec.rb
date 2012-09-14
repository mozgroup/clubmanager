# == Schema Information
#
# Table name: messages
#
#  id                   :integer          not null, primary key
#  author_id            :integer
#  send_to              :string(255)
#  copy_to              :string(255)
#  blind_copy_to        :string(255)
#  subject              :string(255)
#  body                 :text
#  status               :string(255)      default("draft")
#  importance           :string(255)      default("normal")
#  sent_at              :datetime
#  read_receipt_request :boolean          default(FALSE)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

require 'spec_helper'

describe Message do
  it { should belong_to(:author) }
  it { should have_many(:envelopes) }
end
