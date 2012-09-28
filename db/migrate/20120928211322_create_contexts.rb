class CreateContexts < ActiveRecord::Migration
  def change
    create_table :contexts do |t|
      t.string :name
      t.integer :position
      t.integer :user_id

      t.timestamps
    end

    add_index :contexts, [:user_id]
    add_index :contexts, [:user_id, :name]
  end
end
