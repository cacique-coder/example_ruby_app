class ApiController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  before_action :authenticated_user!
  respond_to :json

  def authenticated_user!
    if !current_user
      render nothing: true, status: 401
      return false
    end
  end

  def current_user
    @current_user ||= authenticate_or_request_with_http_token do |token, options|
      User.find_by(token: token)
    end
  end
end
