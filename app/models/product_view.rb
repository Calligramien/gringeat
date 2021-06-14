class ProductView < ApplicationRecord
    validates :views_quantity, presence: true
    validates :code, presence: true
end
