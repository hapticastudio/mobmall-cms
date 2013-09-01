module Api
  module V1
    class ApplicationController < ActionController::Base
      rescue_from ActiveRecord::RecordNotFound, with: :not_authorized

      skip_before_filter :verify_authenticity_token

      protected

      def id
        params.permit(:id)[:id]
      end

      def token
        params.permit(:token)[:token]
      end

      def not_authorized
        head :forbidden
      end

      def authorize
        @device = Device.where(token: token).first!
        @device.update_last_request_at!
      end
    end
  end
end
