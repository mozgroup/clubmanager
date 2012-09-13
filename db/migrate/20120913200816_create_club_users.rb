class CreateClubUsers < ActiveRecord::Migration
  def change
    create_table :club_users do |t|
      t.integer :user_id
      t.integer :club_id

      t.timestamps
    end

    add_index :club_users, [:user_id, :club_id]
  end
end
