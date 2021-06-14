class ProductView < ApplicationRecord
    belongs_to :product
    
    validates :views_quantity, presence: true
    validates :code, presence: true
end
