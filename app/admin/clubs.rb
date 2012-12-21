ActiveAdmin.register Club do
  
  index do
    selectable_column
    id_column
    column :name
    column :abbreviation
    column :address
    column :region
    column :created_at
    default_actions
  end

  show title: :name do
    panel "Club Employees" do
      table_for(club.users) do
        column("Employee ID", sortable: :employee_number) { |user| link_to "#{user.employee_number}", admin_user_path(user) }
        column("Name", sortable: :full_name) { |user| user.full_name }
        column("Title") { |user| user.title }
        column("E-Mail") { |user| user.email }
      end
    end
    active_admin_comments
  end

  sidebar "Club Details", only: :show do
    attributes_table_for club, :name, :region, :address, :created_at
  end

  sidebar "User Actions", only: :show do
    link_to "Add a user", new_admin_user_path(club_id: club.id)
  end

  controller do
    def new
      @club = Club.new(region_id: params[:region_id])
    end
  end
end
