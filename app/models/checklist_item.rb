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
  has_many :completes, :as => :completable, :dependent => :destroy

  def is_complete?(date)
  	!completes.where('created_at >= ? and created_at <= ?', date.beginning_of_day, date.end_of_day).empty?
  end

  def complete
  	self.completes.create
  end
end
