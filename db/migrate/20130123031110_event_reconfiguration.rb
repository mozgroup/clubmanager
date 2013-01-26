class EventReconfiguration < ActiveRecord::Migration
  def change
    rename_table 'events', 'events_save'

    create_table :events do |t|
      t.integer :organizer_id
      t.text    :summary
      t.text    :description
      t.time    :starts_at_time
      t.date    :starts_at_date
      t.date    :ends_at_date
    end

    add_index :events, :organizer_id
    add_index :events, :starts_at_date
    add_index :events, [:starts_at_date, :starts_at_time]
  end
end
