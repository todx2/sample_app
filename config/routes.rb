Rails.application.routes.draw do
  
  get 'sessions/new'

  get  '/signup',  to: 'users#new'

  
  #get 'users/new'

  #get 'static_pages/home'

  #get 'static_pages/help'

  #root 'application#selam'
  #added  ted to make it pass a test
  #get  'static_pages/about'
  #get  'static_pages/contact'
  root 'static_pages#home'

  #now u know this well
  #just to refine only may 16 2018
  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'

  #added to see user/1 from browser but needs more

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'




  resources :users


end
