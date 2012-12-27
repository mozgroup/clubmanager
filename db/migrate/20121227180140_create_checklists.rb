class CreateChecklists < ActiveRecord::Migration
  def change
    create_table :checklists do |t|
      t.integer :user_id
      t.integer :author_id
      t.string :name
      t.string :frequency

      t.timestamps
    end

    add_index :checklists, :user_id
    add_index :checklists, :author_id
    add_index :checklists, :name
  end
end
