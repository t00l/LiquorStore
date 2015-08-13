Rails.application.routes.draw do




resources :products

  post '/rate' => 'rater#create', :as => 'rate'
  get 'comments/new'

  get 'comments/edit'

  get 'comments/create'

  get 'comments/update'

  get 'comments/destroy'

  get 'owners/stores', to: 'owners#stores'

  devise_for :owners, controllers: { registrations: "owners/registrations" }

  resources :stores do
    resources :comments
    resources :offers
    post 'store_products/new' => 'store_products#new', :as => 'store_products'
  end

  post 'stores/create_store_product' => 'stores#create_store_product', :as => 'create_store_product'
  
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }

  root 'stores#index'

  devise_scope :user do
    delete 'sign_out', :to => 'devise/sessions#destroy'
  end
end
