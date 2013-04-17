ActiveAdmin.register Department do

  index do
    selectable_column
    id_column
    column :name
    column :description
    column :created_at
    default_actions
  end

end
