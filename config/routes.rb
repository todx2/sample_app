Rails.application.routes.draw do
  get 'static_pages/home'

  get 'static_pages/help'

  #root 'application#selam'
  #added  ted to make it pass a test
  get  'static_pages/about'
  get  'static_pages/contact'
  root 'static_pages#home'

end
