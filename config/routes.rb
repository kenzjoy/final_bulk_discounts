Rails.application.routes.draw do

  get 'merchants/:id/dashboard', to: 'merchants#show'
  patch '/merchants/:id', to: 'merchants#update'

  resources :merchants, except: [:update] do
    resources :items, except: [:update]
  end

  patch '/merchants/:merchant_id/items/:id', to: 'items#update'

  resources :merchants, except: [:update] do
    resources :invoices, except: [:update]
  end

  resources :merchants, only: [:show] do
    resources :bulk_discounts
  end

  patch '/merchants/:merchant_id/invoices/:id', to: 'invoices#update'

  namespace :admin do
    resources :merchants, except: [:update]
  end

  namespace :admin do
    resources :invoices, except: [:update]
  end

  patch '/admin/invoices/:id', to: 'admin/invoices#update'

  resources :admin, only: [:index]
  # get '/admin', to: 'admin#index'

  patch '/admin/merchants/:id', to: 'admin/merchants#update'
end

# try to model this down the road
# resources :merchant, only: [:show] do
#   resources :bulk_discounts
#   resources :dashboard, only: [:index]
#   resources :items, except: [:destroy]
#   resources :item_status, only: [:update]
#   resources :invoices, only: [:index, :show, :update]
# end

# namespace :admin do
#   resources :dashboard, only: [:index]
#   resources :merchants, except: [:destroy]
#   resources :merchant_status, only: [:update]
#   resources :invoices, except: [:new, :destroy]
# end