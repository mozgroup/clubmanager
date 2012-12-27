class CheckListItem < ActiveRecord::Base
  attr_accessible :check_list_id, :complete_flg, :due_on, :name

  belongs_to :check_list
end
