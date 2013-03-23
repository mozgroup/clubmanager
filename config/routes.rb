ClubManager::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  devise_for :users

  devise_scope :user do
    get "sign_in", :to => "devise/sessions#new"
  end

  get 'inbox', to: 'inbox#index', as: 'inbox'
  get 'inbox/refresh', to: 'inbox#refresh', as: 'inbox_refresh'
  put 'envelopes/:envelope_id/trash', to: 'envelopes#trash', as: 'envelope_trash'
  put 'envelopes/:envelope_id/delete', to: 'envelopes#delete', as: 'envelope_delete'
  put 'envelopes/:envelope_id/mark_important', to: 'envelopes#mark_important', as: 'envelope_mark_important'
  get 'users/search', to: 'users#search', as: 'search_users'
  get 'agenda', to: 'agenda#index', as: 'agenda'
  get 'calendar', to: 'calendar#index', as: 'calendar'
  get 'tasks/context/:context_id', to: 'tasks#context', as: 'context_tasks'
  get 'tasks/project/:project_id', to: 'tasks#project', as: 'project_tasks'

  resources :attachments, only: [:create, :destroy]
  resources :checklist_items, only: [:show, :update, :edit, :destroy] do
    member do
      put :complete
      put :complete_sub_item
      put :undo_complete
      put :undo_complete_sub_item
      put :sidebar_complete
    end
  end
  resources :tasks do
    get 'my_tasks', on: :collection
    get 'assigned', on: :collection
    get 'in_progress', on: :collection
    get 'completed', on: :collection
    get 'assign', on: :member
    put 'update_assigned_to', on: :member
    put 'update_claimed', on: :member
    put 'start', on: :member
    put 'complete', on: :member
  end
  resources :projects do
    get 'search', on: :collection
  end
  resources :contexts do
    get 'search', on: :collection
  end
  resources :messages do
    collection do
      get 'inbox'
      get 'drafts'
      get 'sent'
      get 'trash'
      get 'cancel'
    end

    get 'reply'
    get 'forward'
    put 'trash'
    put 'delete'
  end
  resources :envelopes
  resources :events
  resources :monthly_summaries do
    get 'forecast', on: :collection

    resources :daily_summaries
  end
  resources :checklists
  resources :users do
    get 'change_password', on: :member
  end

  root to: 'home#index'

#  match '/signin', to: 'sessions#new'
#  match '/signout', to: 'sessions#destroy', via: :delete
#  resources :sessions, only: [:new, :create, :destroy]
#  resources :password_resets


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
