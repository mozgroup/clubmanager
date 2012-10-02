class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.integer :owner_id
      t.integer :position
      t.integer :context_id

      t.timestamps
    end

    add_index :projects, [:owner_id]
    add_index :projects, [:owner_id, :name]
  end
end
