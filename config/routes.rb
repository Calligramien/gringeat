Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :products, except: :show do 
    resources :reviews, only: [ :new, :create ]
    post :get_barcode, on: :collection
    resources :reviews, only: [:create ]
  end
get "/product/:code", to: "products#show", as: :product_detail
end
