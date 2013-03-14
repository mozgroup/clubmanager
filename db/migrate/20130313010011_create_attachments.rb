class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string :item
      t.integer :attachable_id
      t.string :attachable_type

      t.timestamps
    end
  end
end
