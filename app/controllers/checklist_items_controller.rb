class ChecklistItemsController < ApplicationController
	def complete
		@checklist_item = ChecklistItem.find params[:id]
		@checklist_item.complete
	end
end