class Product < ApplicationRecord
   has_many :favourites, dependent: :destroy   
end
