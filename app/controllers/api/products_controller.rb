module Api
  class ProductsController < ApiController

    def available
      render json: Product.available
    end

    def last_update
      render json: Product.last_update
    end

  end
end
