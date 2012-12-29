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
  	start_date = date.beginning_of_day
  	end_date = date.end_of_day
  	if checklist.is_weekly?
  		start_date = date.beginning_of_week
  		end_date = date.end_of_week
  	elsif checklist.is_monthly?
  		start_date = date.beginning_of_month
  		end_date = date.end_of_month
  	end

  	!completes.where('created_at >= ? and created_at <= ?', start_date, end_date).empty?
  end

  def complete
  	self.completes.create
  end
end
