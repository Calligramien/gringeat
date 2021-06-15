class ReviewsController < ApplicationController
  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.product_code = params[:code]
    @review.user = current_user
    if @review.save
      redirect_to product_detail_path(params[:code])
    else
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

      @reviews = Review.where(product_code:params[:code])

      @favorite = current_user.favorites.find_by(product_code: @product.code)
      render "products/show"
      # flash[:alert] = "Already done"
      # redirect_to product_detail_path(params[:code])
    end
  end

  private

  def review_params
    params.require(:review).permit(:content, :ratings)
  end
end
