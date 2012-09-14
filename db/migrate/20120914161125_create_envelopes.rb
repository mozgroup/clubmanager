class CreateEnvelopes < ActiveRecord::Migration
  def change
    create_table :envelopes do |t|
      t.integer :message_id
      t.integer :recipient_id
      t.boolean :read_flag
      t.boolean :trash_flag
      t.boolean :delete_flag

      t.timestamps
    end

    add_index :envelopes, :message_id
    add_index :envelopes, :recipient_id
  end
end
