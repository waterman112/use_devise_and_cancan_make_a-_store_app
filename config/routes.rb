Rails.application.routes.draw do
  devise_for :users

  resources :items
  resources :roles
  scope "/admin" do
    resources :users
  end

  authenticated :user do
    root :to => 'items#index', as: :authenticated_root
  end

  root to: "welcome#index"
end
