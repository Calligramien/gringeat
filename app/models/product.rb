class Product < ApplicationRecord
   has_many :product_view
   has_many :favourites, dependent: :destroy   
end
