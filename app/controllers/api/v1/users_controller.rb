class Api::V1::UsersController < BaseController
  before_action :doorkeeper_authorize!
  respond_to :json

  def show
    if params[:id]
      user = find_user
    else
      user = current_user
    end
    logger.info user.as_json
    respond_with user.as_json(except: :password_digest)
  end

end
