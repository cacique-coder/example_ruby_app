class ClientsController < AuthenticationController
  before_action :set_client, only: [:show, :edit, :update, :destroy, :change_status]

  # GET /clients
  def index
    @q = Client.includes(zone: :user).ransack(params[:q])
    @clients = @q.result.page(params[:page]).decorate
  end

  # GET /clients/1
  def show
    @client = @client.decorate
  end

  # GET /clients/new
  def new
    @client = Client.new
  end

  # GET /clients/1/edit
  def edit
  end

  # POST /clients
  def create
    @client = Client.new(client_params)

    if @client.save
      redirect_to @client, notice: 'Client fue creato exitosamente.'
    else
      render :new
    end
  end

  # PATCH/PUT /clients/1
  def update
    if @client.update(client_params)
      redirect_to @client, notice: 'Client was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /clients/1
  def destroy
    @client.destroy
    redirect_to clients_url, notice: 'Client was successfully destroyed.'
  end

  def change_status
    @client.change_status!
    redirect_to client_path(@client)
  end
  private

  # Use callbacks to share common setup or constraints between actions.
  def set_client
    @client = Client.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def client_params
    params.require(:client).permit(:cliente, :cliente_optional, :zona_postal, :rif, :zone_id,
                   :description, :status, :direction, :contribuyente_especial,
                   :telefono,:saint_id)
  end
end
