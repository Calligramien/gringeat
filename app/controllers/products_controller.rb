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
    @reviews = Review.where(product_code:params[:code])

    @products_datas = {}
    @products.each do |product|
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

  def show

    # récupérer le produit scanné ou sélectionné et afficher la page produit
    @product = Openfoodfacts::Product.get(params[:code], locale: 'fr')

    # on récupère la liste des catégories en string et on la transforme en array
    categories = @product.categories.split(",") 
    min_index = 0
    max_index = categories.length - 1 # on soustrait 1 car un array, son index démarre à 0    
    godOfRandom = rand(min_index..max_index)
    @keywords = categories[min_index] + ", " + categories[godOfRandom]

    # permet de faire une recherche par catégorie et afficher des produits qui pourraient intéressé
    @products = Openfoodfacts::Product.search(@keywords, locale: 'fr', page_size: 5)
    
    @product_view = ProductView.find_by(code: params[:code])
    if @product_view
      @product_view.views_quantity += 1
      @product_view.save
    else
      @product_view = ProductView.create(
        code: params[:code],
        views_quantity: 1
      )
    end

    @products_datas = {}
    @products.each do |product|
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

    @review = Review.new
    @reviews = Review.where(product_code:params[:code])

    @favorite = current_user.favorites.find_by(product_code: @product.code)

    sumratings = 0

    if @reviews.count > 0
      @reviews.each do |review|
        sumratings += review.ratings
      end
      @average = sumratings / @reviews.count
    end

  end

  def get_barcode
    @product = Product.find_or_initialize_by(upc: params[:upc])
  end

  def scan
    @selected_btn = "scan"
  end
end
