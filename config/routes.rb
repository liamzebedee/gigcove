Rails.application.routes.draw do
  devise_for :users, :controllers => { :sessions => "users/sessions" }
  
  root :to => 'pages#index'
  get 'contact', to: 'pages#contact'

  resources :gigs do
    collection do
      get 'unmoderated'
    end
  end
end
