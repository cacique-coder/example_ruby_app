module Api
  class AuthenticationController < ::ApiController
    skip_before_action :authenticated_user!

    def login
      user =  User.custom_authentication(params_user)
      if user
        render json: user
      else
        head status: 422
      end
    end

    def check_token
      authenticated_user!
      head :no_content
    end

    def params_user
      params.require(:user).permit(:login, :password)
    end

  end
end
