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
#

require 'spec_helper'

describe Checklist do
  pending "add some examples to (or delete) #{__FILE__}"
end
