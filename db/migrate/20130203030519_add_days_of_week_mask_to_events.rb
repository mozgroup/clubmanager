class AddDaysOfWeekMaskToEvents < ActiveRecord::Migration
  def change
    add_column :events, :days_of_week_mask, :integer
  end
end
