class FavoritesController < ApplicationController
  
  def index
     @favorites = Favorite.all.map do |f|
      Openfoodfacts::Product.get(f.product_code, locale: 'fr')
     end
      @favorite = Favorite.all
  end
  
  def create
    if Favorite.create!(product_code: params[:code], user: current_user)
      redirect_to product_detail_path(params[:code]), notice: 'Product has been favorited'
    else
      redirect_to product_detail_path(params[:code]), alert: 'Something went wrong...'
    end
  end
  
  def toggle_favorite
    product = params[:code]
    if Favorite.find_by(product_code: product)
      Favorite.find_by(product_code: product).destroy
    else
      Favorite.create!(product_code: params[:code], user: current_user)
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
