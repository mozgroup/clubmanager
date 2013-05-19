ActiveAdmin.register User do
  index do
    column :full_name
    column :email
    column :department
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
      f.input :department
      f.input :clubs
      f.input :roles, as: :check_boxes, collection: User::ROLES
      f.input :password
      f.input :password_confirmation
      f.buttons
    end
  end

  controller do
    def new
      @user = User.new(club_ids: params[:club_id])
    end
  end

  def scoped_collection
    User.includes(:clubs)
  end

  show do
    h3 user.full_name
    attributes_table do
      row :id
      row :email
      row :sign_in_count
      row :last_sign_in_at
      row :employee_number
      row :title
      row :roles
      row :created_at
      row :updated_at
    end

    panel 'Mailboxes for this user' do
      table_for(user.mailboxes) do
        column("Name") { |mailbox| link_to mailbox.name, admin_mailbox_path(mailbox) }
        column("Username") { |mailbox| mailbox.username }
        column("Host") { |mailbox| mailbox.host }
        column("Port") { |mailbox| mailbox.port }
      end
    end
  end

  sidebar 'Mailbox Actions', only: :show do
    link_to 'Add a mailbox', new_admin_mailbox_path(user_id: user.id)
  end
end
