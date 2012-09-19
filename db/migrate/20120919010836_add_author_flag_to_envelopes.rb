class AddAuthorFlagToEnvelopes < ActiveRecord::Migration
  def change
    add_column :envelopes, :author_flag, :boolean, default: false
  end
end
