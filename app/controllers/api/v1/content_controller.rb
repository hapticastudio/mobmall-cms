module Api
  module V1
    class ContentController < ActionController::Base
      def index
        device = Device.where(token: token).first
        unless device
          head :forbidden
        else
          places = Local.all

          json = {
            content: {
              places: places
            }
          }

          render json: json
        end
      end

      private

      def token
        params.permit(:id)[:id]
      end
    end
  end
end
