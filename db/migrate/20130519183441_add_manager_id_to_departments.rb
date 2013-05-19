class AddManagerIdToDepartments < ActiveRecord::Migration
  def change
    add_column :departments, :manager_id, :integer
  end
end
