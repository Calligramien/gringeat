Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :products, except: :show do  
    post :get_barcode, on: :collection
    resources :favourites, only: [:create ]
  end


  
  get "/product/:code", to: "products#show", as: :product_detail  
  post "/product/:code/reviews", to: "reviews#create"

  get "/scan", to: "products#scan", as: :scan

end
