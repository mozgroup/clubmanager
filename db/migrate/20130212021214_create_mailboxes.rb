class CreateMailboxes < ActiveRecord::Migration
  def change
    create_table :mailboxes do |t|
      t.belongs_to :user
      t.string :name
      t.string :host
      t.string :port
      t.boolean :ssl
      t.string :domain
      t.string :username
      t.string :password_digest
      t.boolean :starttls_auto

      t.timestamps
    end
    add_index :mailboxes, :user_id
  end
end
