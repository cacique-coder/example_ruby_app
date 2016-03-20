module Api
  class DiscountsController < ApiController

    def index
      render json: Discount.all
    end
  end
end
