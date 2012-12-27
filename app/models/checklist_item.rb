class ChecklistItem < ActiveRecord::Base
  attr_accessible :checklist_id, :name

  belongs_to :checklist
end
