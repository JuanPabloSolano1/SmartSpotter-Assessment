module Api
  module V1
    class RoomsController < ApplicationController
      # you can find these includes in controllers/concers
      include Response
      include ExceptionHandler

      def index
        @rooms = Room.all
        json_response(@rooms)
      end

      def show
        @room = Room.find(params[:id])
        json_response(@room)
      end
    end
  end
end
