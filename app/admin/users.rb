ActiveAdmin.register User do
  index do
    column :full_name
    column :email
    column :current_sign_in_at
    column :last_sign_in_at
    column :sign_in_count
    default_actions
  end

  filter :last_name
  filter :email
  filter :employee_number
  filter :title

  form do |f|
    f.inputs "Employee Details" do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :employee_number
      f.input :title
      f.input :password
      f.input :password_confirmation
    end
    f.buttons
  end
end
