class CreateClubs < ActiveRecord::Migration
  def change
    create_table :clubs do |t|
      t.string :name
      t.integer :region_id
      t.text :address

      t.timestamps
    end

    add_index :clubs, :region_id
    add_index :clubs, :name
  end
end
