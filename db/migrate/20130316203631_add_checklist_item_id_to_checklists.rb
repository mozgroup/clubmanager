class AddChecklistItemIdToChecklists < ActiveRecord::Migration
  def change
    add_column :checklists, :checklist_item_id, :integer
  end
end
