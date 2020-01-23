Rails.application.routes.draw do
  #get 'foo/bar' rails destroy didn't delete these 2 lines...
  #get 'foo/baz'
  get 'static_pages/home'
  get 'static_pages/help'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'static_pages/about'
  get 'static_pages/contact'
root 'static_pages#home'
end
