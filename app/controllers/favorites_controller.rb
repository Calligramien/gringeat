class FavoritesController < ApplicationController
  
  def index
     @favorites = Favorite.all.map do |f|
      Openfoodfacts::Product.get(f.product_code, locale: 'fr')
     end
    @favorite = Favorite.all

    @products_datas = {}
    @favorites.each do |f|
      product_reviews = Review.where(product_code: f.code)
      sumratings = 0
      if product_reviews.count > 0
        @products_datas[f.code] = {}
        product_reviews.each do |review|
          sumratings += review.ratings
        end
        @products_datas[f.code][:average_rating] = sumratings / product_reviews.count
        @products_datas[f.code][:reviews_count] = product_reviews.count
      end
      end  
  end
  
  def create
    if Favorite.create!(product_code: params[:code], user: current_user)
      redirect_to product_detail_path(params[:code]), notice: 'Product has been favorited'
    else
      redirect_to product_detail_path(params[:code]), alert: 'Something went wrong...'
    end
  end
  
  def destroy
    favorite = Favorite.find(params[:id])
    product_code = favorite.product_code
    favorite.destroy
    if request.referer.end_with?("favorites")
      redirect_to product_favorite_list_path, notice: 'Product is no longer in favorites'
    else
      redirect_to product_detail_path(product_code), notice: 'Product is no longer in favorites'
    end
  end
  

end
