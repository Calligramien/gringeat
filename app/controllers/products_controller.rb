class ProductsController < ApplicationController
  def index
     if params[:query].present?
      @products= Openfoodfacts::Product.search(params[:query], locale: 'world', page_size: 5)
    else
      @products= "pas de produit"
    end
  end

  def show
    @product = Openfoodfacts::Product.get(params[:code], locale: 'fr')

  end

  def get_barcode
    @product = Product.find_by(upc: params[:upc])
  end
end
