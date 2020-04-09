Rails.application.routes.draw do
  #get 'charges/new'
  #get 'charges/create'
  
  get 'checkout/new'
  get 'checkout/create'

  resources :charges, only: [:new, :create]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
