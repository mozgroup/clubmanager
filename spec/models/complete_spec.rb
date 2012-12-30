# == Schema Information
#
# Table name: completes
#
#  id               :integer          not null, primary key
#  completable_id   :integer
#  completable_type :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'spec_helper'

describe Complete do
  pending "add some examples to (or delete) #{__FILE__}"
end
