module Api
  class OrdersController < ApiController

    def show
      render json: Order.find(params[:id])
    end

    def create
      order = current_user.orders.create(params_order)
      if order.valid?
        render json: order
      else
        render json: {error: order.errors.full_messages}, status: 421
      end
    end
    private

    def order_json
      @order_json ||= Order.find(params[:id])
    end

    def params_order
      params.require(:order).permit(:discount, :comentario,
          :client_id, items_attributes: items_attributes)
    end
    def items_attributes
      [:item_code, :quantity]
    end
  end
end
