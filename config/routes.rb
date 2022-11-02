Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'merchants/:id/items', to: 'merchant_items#index'
  
  patch 'items/:id', to: 'items#update'

end
