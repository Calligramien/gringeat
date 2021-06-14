class ProductsController < ApplicationController
  def index
    if params[:query].present?
      @products = Openfoodfacts::Product.search(params[:query], locale: 'fr', page_size: 12)
    else
      redirect_to root_path
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

  def scan
  end
end
