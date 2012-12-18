class CreateMonthlySummaries < ActiveRecord::Migration
  def change
    create_table :monthly_summaries do |t|
      t.integer  :club_id
      t.datetime :month
      t.integer  :business_days_in_month
      t.decimal  :membership_goal, precision: 8, scale: 2
      t.decimal  :training_goal, precision: 8, scale: 2
      t.decimal  :juice_bar_goal, precision: 8, scale: 2
      t.decimal  :nursery_goal, precision: 8, scale: 2
      t.decimal  :membership_draft_expected, precision: 8, scale: 2
      t.decimal  :training_draft_expected, precision: 8, scale: 2

      t.timestamps
    end

    add_index :monthly_summaries, :club_id
    add_index :monthly_summaries, :month
  end
end
