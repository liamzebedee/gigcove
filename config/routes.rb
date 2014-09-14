Rails.application.routes.draw do
  # Devise
  devise_for :users, :controllers => { 
    sessions: "users/sessions", 
    registrations: 'users/registrations',
    omniauth_callbacks: "users/omniauth_callbacks" }
  
  # Static pages
  root :to => 'pages#index'
  get 'contact', to: 'pages#contact'

  # Instagram
  get '/instagram/subscription_callback', to: 'instagram#verify_subscriptions'
  post '/instagram/subscription_callback', to: 'instagram#update'

  # Gigs
  resources :gigs, only: [:index, :new, :create, :show, :update] do
    collection do
      get 'unmoderated'
    end
  end
  

  resources :genres, only: [:index] do
  end
  resources :venues, only: [:index, :show, :edit]
  resources :artists, only: [:index, :show]
end
