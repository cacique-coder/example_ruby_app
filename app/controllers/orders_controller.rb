class OrdersController < AuthenticationController
  before_action :set_order, only: [:review, :show, :edit, :update, :destroy]

  # GET /orders
  def index
    @search = Order.includes(:user,:client).ransack(params[:q])
    @orders = @search.result.page(params[:page]).decorate
  end

  # GET /orders/1
  def show
    @order = @order.decorate
  end

  def review
    @order.review!
    redirect_to(orders_path, notice: 'Procesar')
  end

  # POST /orders
  def create
    @order = Order.new(order_params)

    if @order.save
      redirect_to @order, notice: 'Order fue creato exitosamente.'
    else
      render :new
    end
  end

  # PATCH/PUT /orders/1
  def update
    if @order.update(order_params)
      redirect_to @order, notice: 'Order was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /orders/1
  def destroy
    @order.destroy
    redirect_to orders_url, notice: 'Order was successfully destroyed.'
  end

  def massive_update
    raise
    ParserProducts.new()
    redirect_to products_path
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def order_params
      params[:order]
    end

end
