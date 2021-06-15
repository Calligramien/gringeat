class PagesController < ApplicationController
    skip_before_action :authenticate_user!, only: :home
  def home
    @most_viewed_products = ProductView.order("views_quantity DESC").limit(5).map do |pv|
      Openfoodfacts::Product.get(pv.code, locale: 'fr')
    end
    
    @products_datas = {}
    @most_viewed_products.each do |product|
      product_reviews = Review.where(product_code: product.code)
      sumratings = 0
      if product_reviews.count > 0
        @products_datas[product.code] = {}
        product_reviews.each do |review|
          sumratings += review.ratings
        end
        @products_datas[product.code][:average_rating] = sumratings / product_reviews.count
        @products_datas[product.code][:reviews_count] = product_reviews.count
      end
    end
  end
end
