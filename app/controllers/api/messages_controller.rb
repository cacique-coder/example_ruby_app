module Api
  class MessagesController < ApiController

    def index
      render json: Message.all
    end

    def show
      render json: Message.find(:id)
    end
  end
end
