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


      @reviews_count = Review.group(:product_code).count
      @average_ratings =  Review.group(:product_code).average(:ratings).transform_values(&:to_i).sort_by { |k, v| -v}.to_h

      @ratings_datas = @average_ratings.map {|code, rating|
        { 
          product: Openfoodfacts::Product.get(code, locale: 'fr'),
          average_rating: rating,
          reviews_count: @reviews_count[code]
        }  
      }
      @selected_btn="home"
    end
end

