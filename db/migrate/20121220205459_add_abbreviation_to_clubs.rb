class AddAbbreviationToClubs < ActiveRecord::Migration
  def change
    add_column :clubs, :abbreviation, :string
  end
end
