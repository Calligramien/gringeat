class ReviewsController < ApplicationController

  def create
    @review = Review.new(review_params)
    @review.product_code = params[:code]
    @review.user = current_user
      if @review.save
        redirect_to product_detail_path(params[:code])
      else
        flash[:alert]= "Already done"
        redirect_to product_detail_path(params[:code])
      end
  end

  private

  def review_params
    params.require(:review).permit(:content, :ratings)
  end

end
