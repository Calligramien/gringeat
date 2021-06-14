class PagesController < ApplicationController
    skip_before_action :authenticate_user!, only: :home
  def home
    @most_viewed_products = ProductView.order("views_quantity DESC").limit(5).map do |pv|
      Openfoodfacts::Product.get(pv.code, locale: 'fr')
    end
  end
end
