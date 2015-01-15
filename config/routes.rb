Rails.application.routes.draw do
  # Devise
  devise_for :users, :controllers => { 
    sessions: "users/sessions", 
    registrations: 'users/registrations',
    omniauth_callbacks: "users/omniauth_callbacks" }
  
  # Static pages
  root :to => 'pages#index'
  get 'hello', to: 'pages#hello'
  get 'contribute', to: 'pages#contribute'

  # Instagram
  get '/instagram/subscription_callback', to: 'instagram#verify_subscriptions'
  post '/instagram/subscription_callback', to: 'instagram#update'

  # Gigs
  resources :gigs, only: [:index, :new, :create, :show, :update] do
    collection do
      get 'unmoderated'
    end
  end
  resources :tags, only: [:index] do
  end
  resources :venues, only: [:index, :new, :create, :show, :edit]
end
