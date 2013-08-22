module Api
  module V1
    class ContentController < ApplicationController
      before_filter :authorize

      def index
        places = Local.all
        render json: {content: {places: places}}
      end
    end
  end
end
