class Review < ApplicationRecord
  belongs_to :user
  validates :product_code, presence: true
  validates_uniqueness_of :user_id, :scope => [:product_code] 
end
