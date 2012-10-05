class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.datetime :due_at
      t.datetime :completed_at
      t.integer :context_id
      t.integer :project_id
      t.integer :owner_id
      t.text :notes
      t.string :state

      t.timestamps
    end

    add_index :tasks, :context_id
    add_index :tasks, :project_id
    add_index :tasks, :owner_id
    add_index :tasks, :state
  end
end
