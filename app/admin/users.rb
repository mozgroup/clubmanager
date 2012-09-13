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
    f.inputs "User Details" do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :employee_number
      f.input :title
      f.input :password
      f.input :password_confirmation
      f.input :clubs
    end
    f.buttons
  end

  controller do
    def new
      @user = User.new(club_ids: params[:club_id])
    end
  end

  def scoped_collection
    User.includes(:clubs)
  end

end
