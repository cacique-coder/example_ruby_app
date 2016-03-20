class ProductsController < AuthenticationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  def index
    @search = Product.ransack(params[:q])
    @products = @search.result.page(params[:page]).decorate
  end

  # GET /products/1
  def show
    @product = @product.decorate
  end

  def upload_file
  end

  def massive_process
    FileToArray.new(file_params).to_run do |array|
      ParserProductsJob.new.perform(array)
    end
    redirect_to products_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    def file_params
      params[:file][:productos]
    end
end
