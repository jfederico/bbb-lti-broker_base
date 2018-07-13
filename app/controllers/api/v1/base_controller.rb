class Api::V1::BaseController < ApplicationController

  private

    def current_user
      logger.info "------------------current_user-------------------------"
      if doorkeeper_token
        logger.info "Doorkeeper token found"
        @current_user ||= User.find(doorkeeper_token.resource_owner_id)
      else
        logger.info "Doorkeeper token NOT found"
        nil
      end
    end

    def find_user
      logger.info "---------------------find_user----------------------"
      if doorkeeper_token
        logger.info "Doorkeeper token found"
        User.find(params[:id])
      else
        logger.info "Doorkeeper token NOT found"
        nil
      end
    end

end
