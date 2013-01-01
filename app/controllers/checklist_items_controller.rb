class ChecklistItemsController < ApplicationController
	def complete
	  complete_item
	end

	def sidebar_complete
	  complete_item
	end

	protected

	def complete_item
	  @checklist_item = ChecklistItem.find params[:id]
	  @checklist_item.complete
	end
end