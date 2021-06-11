class ProductsController < ApplicationController
  def index
    if params[:query].present?
      @products = Openfoodfacts::Product.search(params[:query], locale: 'world', page_size: 5)
    else
      render :home
    end
  end

  def show
    @product = Openfoodfacts::Product.get(params[:code], locale: 'fr')
    @review = Review.new
    @reviews = Review.all
  end

  def get_barcode

    @product = Product.find_or_initialize_by(upc: params[:upc])
  end

end
