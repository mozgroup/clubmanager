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
  get 'home', to: 'home#index', as: 'home'

  resources :attachments, only: [:create, :destroy]
  resources :checklists do
    collection do
      get 'reports_daily_incomplete'
      get 'reports_daily_complete'
      get 'reports_weekly_incomplete'
      get 'reports_weekly_complete'
      get 'reports_monthly_incomplete'
      get 'reports_monthly_complete'
    end
  end
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
    member do
      get 'assign'
      put 'update_assigned_to'
      put 'update_claimed'
      put 'start'
      put 'complete'
    end
    collection do
      get 'my_tasks'
      get 'assigned'
      get 'in_progress'
      get 'completed'
      get 'rpt_all'
      get 'reports'
    end
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
  resources :users do
    get 'change_password', on: :member
  end

  root to: 'inbox#index'
end
