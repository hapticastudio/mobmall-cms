module Api
  module V1
    class ApplicationController < ActionController::Base
      private

      def token
        params.permit(:id)[:id]
      end

      def authorize
        @device = Device.where(token: token).first
        head :forbidden unless @device
      end
    end
  end
end
