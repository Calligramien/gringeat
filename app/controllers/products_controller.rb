class ProductsController < ApplicationController
  has_many :product_views
  
  def index
    if params[:query].present?
      @products = Openfoodfacts::Product.search(params[:query], locale: 'fr', page_size: 12)
    else
      render "pages/home"
    end
  end

  def show
    @product = Openfoodfacts::Product.get(params[:code], locale: 'fr')
    if exist? Product.code 
      @product = Product.code.views_quantity += 1
      @product = Product.save
    else 
      @product = Product.views_quantity.create
      @product = Product.code.views_quantity += 1
      @product = Product.save
    end


    @review = Review.new
    @reviews = Review.all
  end

  def get_barcode
    @product = Product.find_or_initialize_by(upc: params[:upc])
  end

  def scan
  end

end
