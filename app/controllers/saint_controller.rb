class SaintController < AuthenticationController

  def pending
    @orders = Saint::PendingOrders.new.hash
    render json: @orders, root: false
  end

  def sincronize
    Order.review_orders(params_sincronized)
    render nothing: true, status: 203
  end

  private

  def params_sincronized
    params['order']
  end
end
