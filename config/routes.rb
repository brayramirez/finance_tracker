FinanceTracker::Application.routes.draw do

  devise_for :users

  # resources :categories

  resources :cutoffs, :only => [:index, :show, :create, :edit, :update, :destroy] do
    resources :daily_records, :only => [:create]
  end

  resources :daily_records, :only => [:index, :show, :edit, :update, :destroy] do
    resources :line_items, :only => [:create]
  end

  resources :line_items, :only => [:show, :edit, :update, :destroy]

  resources :users, :only => [:edit, :update]

  namespace :admin do
    resources :users
  end


  root 'cutoffs#index'
end
