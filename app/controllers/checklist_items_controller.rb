class ChecklistItemsController < ApplicationController
  before_filter :get_layout_data

  def complete
    complete_item
  end

  def sidebar_complete
    complete_item
  end

  def undo_complete
    @checklist_item = ChecklistItem.find params[:id]
    @checklist_item.undo_complete
  end

  def show
    @checklist_item = ChecklistItem.find params[:id]
  end

  protected

  def complete_item
    @checklist_item = ChecklistItem.find params[:id]
    @checklist_item.complete
  end
end
