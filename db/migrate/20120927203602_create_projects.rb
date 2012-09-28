class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.integer :user_id
      t.integer :position
      t.integer :context_id

      t.timestamps
    end

    add_index :projects, [:user_id]
    add_index :projects, [:user_id, :name]
  end
end
