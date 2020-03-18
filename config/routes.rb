Rails.application.routes.draw do
  root 'static_pages#home'
  get '/signup', to: 'users#new'
  #get 'static_pages/home'
  get '/help', to: 'static_pages#help'#, as:'helf'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users # endows our sample application with all the actions needed for a RESTful Users resource.
  resources :account_activations, only: [:edit]
end
