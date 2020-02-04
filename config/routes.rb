Rails.application.routes.draw do
  get '/signup', to: 'users#new'
  #get 'static_pages/home'
  get '/help', to: 'static_pages#help'#, as:'helf'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
root 'static_pages#home'
end
