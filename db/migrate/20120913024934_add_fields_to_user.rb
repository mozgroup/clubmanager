class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :employee_number, :string
    add_column :users, :title, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
  end
end
