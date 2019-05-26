Rails.application.routes.draw do
  devise_for :users,
             :controllers => { :confirmations => "users/confirmations", :registrations => "users/registrations", :sessions => "users/sessions"}
  root 'home#index'
  resources :specialties, :reviews
  resources :specialists do
    collection do
      get 'find'
      get 'findJSON'
    end
    member do
      get 'getReviews'
      get 'confirm'
      get 'details'
    end
  end

  resources :messages
  devise_scope :user do
    get 'mySpecialists', to: 'users/sessions#mySpecialists'
    get 'myMessages', to: 'users/sessions#myMessages'
    get 'sentMessages', to: 'users/sessions#sentMessages'
    get 'receivedMessages', to: 'users/sessions#receivedMessages'
  end

  get '/awaitingConfirmation', to: 'home#awaitingConfirmation', as: :awaitingConfirmation
  get '/link_expired', to: 'home#link_expired', as: :link_expired
  get '/specialist_created', to: 'home#specialist_created', as: :specialist_created
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
