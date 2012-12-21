class CreateDailySummaries < ActiveRecord::Migration
  def change
    create_table :daily_summaries do |t|
      t.integer :monthly_summary_id
      t.decimal :membership_cash, precision: 8, scale: 2
      t.decimal :training_cash, precision: 8, scale: 2
      t.decimal :juice_bar_cash, precision: 8, scale: 2
      t.decimal :nursery_cash, precision: 8, scale: 2
      t.decimal :membership_draft_cash, precision: 8, scale: 2
      t.decimal :training_draft_cash, precision: 8, scale: 2
      t.integer :membership_cancellations
      t.decimal :membership_cancellations_value, precision: 8, scale: 2
      t.integer :membership_freezes
      t.decimal :membership_freezes_value, precision: 8, scale: 2
      t.integer :membership_delinquents
      t.decimal :membership_delinquents_value, precision: 8, scale: 2
      t.integer :training_cancellations
      t.decimal :training_cancellations_value, precision: 8, scale: 2

      t.timestamps
    end

    add_index :daily_summaries, :monthly_summary_id
  end
end
