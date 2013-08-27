module Api
  module V1
    class DevicesController < ApplicationController
      def create
        @device = Device.new(device_params)
        if @device.save
          render json: @device, status: :ok
        else
          render json: { errors: @device.errors.full_messages }, status: 422
        end
      end

      def update
        @device = Device.where(token: id).first
        if @device.update_attributes(device_params)
          head :ok
        else
          render json: { errors: @device.errors.full_messages }, status: 422
        end
      end

      private

      def device_params
        params.require(:device).permit(:app_version, :push_token, :operating_system)
      end
    end
  end
end
