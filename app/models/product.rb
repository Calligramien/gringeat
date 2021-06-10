class Product < ApplicationRecord
   has_many :reviews, dependent: :destroy
   has_many :favourites, dependent: :destroy
end
