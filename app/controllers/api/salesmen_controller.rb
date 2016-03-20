module Api
  class SalesmenController < ApiController

    def clients
      render json: current_user.clients.actives
    end

    def orders
      render json: current_user.orders.newest.query_mobile
    end

  end
end
