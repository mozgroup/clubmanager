class AddPriorityToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :priority, :integer

    add_index :tasks, :priority
  end
end
