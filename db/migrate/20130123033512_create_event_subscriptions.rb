class CreateEventSubscriptions < ActiveRecord::Migration
  def change
    create_table :event_subscriptions do |t|
      t.integer :event_id
      t.integer :user_id

      t.timestamps
    end
  end
end
