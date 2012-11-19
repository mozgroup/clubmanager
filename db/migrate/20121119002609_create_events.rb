class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :user_id
      t.string :invitee_list
      t.string :subject
      t.string :location
      t.text :description
      t.datetime :start_at
      t.datetime :end_at

      t.timestamps
    end

    add_index :events, :user_id
    add_index :events, :start_at
    add_index :events, :end_at
  end
end
