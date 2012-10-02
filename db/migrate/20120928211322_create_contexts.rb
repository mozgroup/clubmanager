class CreateContexts < ActiveRecord::Migration
  def change
    create_table :contexts do |t|
      t.string :name
      t.integer :position
      t.integer :owner_id

      t.timestamps
    end

    add_index :contexts, [:owner_id]
    add_index :contexts, [:owner_id, :name]
  end
end
