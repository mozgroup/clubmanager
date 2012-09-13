ActiveAdmin.register Region do
  
  config.batch_actions = true

  filter :name

  index do
    selectable_column
    id_column
    column :name
    column :created_at
    column :updated_at
    default_actions
  end
 
  show title: :name do
    panel "Clubs for this region" do
      table_for(region.clubs) do
        column("ID", sortable: :id) { |club| link_to "##{club.id}", admin_club_path(club) }
        column("Name", sortable: :name) { |club| club.name }
        column("Address") { |club| club.address }
        column("Created", sortable: :created_at) { |club| pretty_format(club.created_at) }
        column("Updated", sortable: :updated_at) { |club| pretty_format(club.updated_at) }
      end
    end
    active_admin_comments
  end

  sidebar "Region details", only: :show do
    attributes_table_for region, :name, :created_at, :updated_at
  end

  sidebar "Club Actions", only: :show do
    link_to "Add a club", new_admin_club_path(region_id: region.id)
  end
end
