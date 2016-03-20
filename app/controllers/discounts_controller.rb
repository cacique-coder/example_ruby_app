class DiscountsController < AuthenticationController
  before_action :set_discount, only: [:show, :edit, :update, :destroy]

  def index
    @search = Discount.ransack(params[:q])
    @discounts = @search.result.decorate
  end

  def new
    @discount = Discount.new
  end

  def edit
  end

  def create
    @discount = Discount.new(discount_params)
    if @discount.save
      redirect_to discounts_path, notice: 'Descuento fue creado exitosamente'
    else
      render :new
    end
  end

  def update
    if @discount.update(discount_params)
      redirect_to discounts_path, notice: 'Descuento fue actualizado exitosamente.'
    else
      render :edit
    end
  end

  def destroy
    @discount.destroy
    redirect_to discounts_url, notice: 'Descuento fue eliminado exitosamente.'
  end

  private
    def set_discount
      @discount = Discount.find(params[:id])
    end

    def discount_params
      params.require(:discount).permit(:name, :day, :percent)
    end
end
