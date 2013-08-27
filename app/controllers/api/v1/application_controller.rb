module Api
  module V1
    class ApplicationController < ActionController::Base
      protected

      def id
        params.permit(:id)[:id]
      end

      def token
        params.permit(:token)[:token]
      end

      def authorize
        @device = Device.where(token: token).first
        if @device
          @device.update_last_request_at!
        else
          head :forbidden
        end
      end
    end
  end
end
