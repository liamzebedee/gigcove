Rails.application.routes.draw do
  scope 'api' do
    # Devise
    devise_for :users, :controllers => { 
      sessions: "users/sessions", 
      registrations: 'users/registrations',
      omniauth_callbacks: "users/omniauth_callbacks" }

    # Gigs
    resources :gigs, { only: [:index, :create, :show, :update], defaults: { :format => :json } } do
      collection do
        get 'unmoderated'
      end
    end

    resources :tags, { only: [:index], defaults: { :format => :json } }

    resources :venues, { only: [:index, :create, :show, :update], defaults: { :format => :json } }
  end
end
