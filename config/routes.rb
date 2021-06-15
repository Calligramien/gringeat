Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :products, except: :show do  
    post :get_barcode, on: :collection
    resources :favourites, only: [:create ]
  end

  get "/favorites", to: "favorites#index", as: :product_favorite_list
  post "/products/:code/favorites", to: "favorites#create", as: :product_favorite 
  delete "/favorites/:id", to: "favorites#destroy", as: :favorite_destroy

  get '/products/search', to:"products#search"
  get "/products/:code", to: "products#show", as: :product_detail  

  post "/products/:code/reviews", to: "reviews#create"

  get "/scan", to: "products#scan", as: :scan


end
