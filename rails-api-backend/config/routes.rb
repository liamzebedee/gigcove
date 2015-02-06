Rails.application.routes.draw do
  scope 'api' do
    devise_for :users, :controllers => { 
      sessions: "users/sessions", 
      registrations: 'users/registrations',
      omniauth_callbacks: "users/omniauth_callbacks" }

    resources :gigs, { only: [:index, :create, :show, :update], defaults: { :format => :json } } do
      collection do
        get 'unmoderated'
      end
    end

    resources :tags, { only: [:index], defaults: { :format => :json } }

    resources :venues, { only: [:index, :show], defaults: { :format => :json } }
  end
end
