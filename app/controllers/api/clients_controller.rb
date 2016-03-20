module Api
  class ClientsController < ApiController
#
    def show
      render json: client
    end

    private

    def client
      @client ||= Client.find(params[:id])
    end
  end
end
