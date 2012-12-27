class CreateChecklistItems < ActiveRecord::Migration
  def change
    create_table :checklist_items do |t|
      t.integer :checklist_id
      t.string :name

      t.timestamps
    end

    add_index :checklist_items, :checklist_id
    add_index :checklist_items, :name
  end
end
