class AddDaysOfWeekMaskToChecklist < ActiveRecord::Migration
  def change
    add_column :checklists, :days_of_week_mask, :integer
  end
end
