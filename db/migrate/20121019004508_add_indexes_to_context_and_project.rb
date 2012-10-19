class AddIndexesToContextAndProject < ActiveRecord::Migration
  def change
    add_index :contexts, :name
    add_index :projects, :name
  end
end
