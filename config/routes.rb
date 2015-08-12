Rails.application.routes.draw do
  
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
  end
  
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }

  root 'stores#index'

  devise_scope :user do
    delete 'sign_out', :to => 'devise/sessions#destroy'
  end
end
