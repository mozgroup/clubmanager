class CreateCheckLists < ActiveRecord::Migration
  def change
    create_table :check_lists do |t|
      t.integer :user_id
      t.integer :author_id
      t.string :name
      t.string :frequency

      t.timestamps
    end

    add_index :check_lists, :user_id
    add_index :check_lists, :author_id
    add_index :check_lists, :name
  end
end
