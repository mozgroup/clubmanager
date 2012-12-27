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

class ChecklistItem < ActiveRecord::Base
  attr_accessible :checklist_id, :name

  belongs_to :checklist
end
