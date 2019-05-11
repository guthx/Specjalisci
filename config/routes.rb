Rails.application.routes.draw do
  devise_for :users
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
    end
  end

  devise_scope :user do
    get 'mySpecialists', to: 'devise/sessions#mySpecialists'
  end

  get '/link_expired', to: 'home#link_expired', as: :link_expired
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
