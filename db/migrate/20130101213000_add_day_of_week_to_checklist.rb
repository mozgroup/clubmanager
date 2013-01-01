class AddDayOfWeekToChecklist < ActiveRecord::Migration
  def change
    add_column :checklists, :day_of_week, :integer
  end
end
