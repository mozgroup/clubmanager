class AddTrackingFieldsToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :started_at, :datetime
    add_column :tasks, :claimed_at, :datetime
  end
end
