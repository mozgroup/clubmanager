class CreateCheckListItems < ActiveRecord::Migration
  def change
    create_table :check_list_items do |t|
      t.integer :check_list_id
      t.string :name
      t.string :due_on
      t.boolean :complete_flg

      t.timestamps
    end

    add_index :check_list_items, :check_list_id
    add_index :check_list_items, :name
  end
end
