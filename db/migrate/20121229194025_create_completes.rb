class CreateCompletes < ActiveRecord::Migration
  def change
    create_table :completes do |t|
      t.integer :completable_id
      t.string :completeable_type

      t.timestamps
    end

    add_index :completes, :completable_id
  end
end
