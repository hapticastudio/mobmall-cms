module Api
  module V1
    class ContentController < Api::V1::ApplicationController
      before_filter :authorize

      def index
        places = Local.all
        places = places.updated_since(updated_since) if updated_since

        events = Event.all
        events = events.updated_since(updated_since) if updated_since

        tags   = Tag.all
        tags   = tags.updated_since(updated_since) if updated_since

        render json: {timestamp: time_now, content: {places: places, events: events, tags: tags}}
      end

      private

      def time_now
        (-> { Time.now }.call).utc
      end

      def updated_since
        params.permit(:updated_since)[:updated_since]
      end
    end
  end
end
