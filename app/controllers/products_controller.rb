class ProductsController < ApplicationController
  
  def index
    if params[:query].present?
      session[:search]=params[:query]
      @products = Openfoodfacts::Product.search(params[:query], locale: 'fr', page_size: 12)
    elsif session[:search].present?
      @products = Openfoodfacts::Product.search(session[:search], locale: 'fr', page_size: 12)
   else
      render "pages/home"
    end
  end

  def show
    @product = Openfoodfacts::Product.get(params[:code], locale: 'fr')
    @product_view = ProductView.find_by(code:params[:code])
    if @product_view
      @product_view.views_quantity += 1
      @product_view.save
    else 
      @product_view = ProductView.create(
        code:params[:code],
        views_quantity:1
        )
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
