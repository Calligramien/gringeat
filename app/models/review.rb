class Review < ApplicationRecord
  belongs_to :user
  validates :product_code, presence: true
  validates :content, presence: true
  validates :ratings, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5}
  validates_uniqueness_of :user_id, :scope => [:product_code]

end
