module Api
  module V1
    class DevicesController < ActionController::Base
      def create
        device = Device.new(create_params)
        if device.save
          render json: device, status: :ok
        else
          render json: { errors: device.errors.full_messages }, status: 422
        end
      end

      def update
        device = Device.where(token: token_params).first
        if device
          if device.update_attributes(update_params)
            head :ok
          else
            render json: { errors: device.errors.full_messages }, status: 422
          end
        else
          head :forbidden
        end
      end

      private

      def update_params
        params.require(:device).permit(:app_version, :push_token, :operating_system)
      end

      def token_params
        params.permit(:id)[:id]
      end

      def create_params
        params.require(:device).permit(:app_version)
      end
    end
  end
end
