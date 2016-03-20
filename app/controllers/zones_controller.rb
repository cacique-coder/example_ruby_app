class ZonesController < AuthenticationController
  before_action :set_zone, only: [:show, :edit, :update, :destroy]

  def index
    @q = Zone.includes(:user).ransack(params[:q])
    @zones = @q.result.page(params[:page]).decorate
  end

  def show
    @zone = @zone.decorate
  end

  def new
    @zone = Zone.new
  end

  def edit
  end

  def create
    @zone = Zone.new(zone_params)
    if @zone.save
      redirect_to @zone, notice: 'Zone fue creato exitosamente.'
    else
      render :new
    end
  end

  def update
    if @zone.update(zone_params)
      redirect_to @zone, notice: 'Zone was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @zone.destroy
    redirect_to zones_url, notice: 'Zone was successfully destroyed.'
  end

  private
    def set_zone
      @zone = Zone.find(params[:id])
    end

    def zone_params
      params.require(:zone).permit(:name, :user_id, :description)
    end
end
