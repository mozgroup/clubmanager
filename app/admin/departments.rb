ActiveAdmin.register Department do

  index do
    selectable_column
    id_column
    column :name
    column :manager
    column :created_at
    default_actions
  end

  form do |f|
    f.inputs do
      f.input :manager, as: :select, collection: User.managers
      f.input :name
      f.input :description
      f.buttons
    end
  end
end
