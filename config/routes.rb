Rails.application.routes.draw do
  root 'home#index'
  resources :specialties, :reviews
  resources :specialists do
    collection do
      get 'find'
      get 'findJSON'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
