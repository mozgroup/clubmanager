ActiveAdmin.register Mailbox do

  index do
    selectable_column
    id_column
    column :user
    column :name
    default_actions
  end

  form do |f|
    f.inputs 'Mailbox Details' do
      f.input :user
      f.input :name
      f.input :host
      f.input :port
      f.input :ssl
      f.input :domain
      f.input :username
      f.input :password
      f.input :starttls_auto
    end
    f.buttons
  end

  controller do
    def new
      @mailbox = Mailbox.new(user_id: params[:user_id], port: '143')
    end
  end
end
