class AddAssigneeIdToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :assignee_id, :integer

    add_index :tasks, :assignee_id
    add_index :tasks, [:assignee_id, :due_at]

    Task.all.each do |task|
      task.update_attributes(assignee_id: task.owner_id, state: 'new')
    end
  end
end
