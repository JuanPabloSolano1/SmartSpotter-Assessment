# frozen_string_literal: true

module Api
  module V1
    class ParticipantsController < ApplicationController
      # you can find these includes in controllers/concers
      include Response
      include ExceptionHandler

      def index
        @participants = Participant.where(booking_id: params[:booking_id])
        json_response(@participants)
      end

      def create
        @participant = Participant.new(participants_params)
        @participant.invitee_id = current_user.id
        @participant.save!
        authorize @participant
        json_response(@participant)
      end

      def participants_params
        params.permit(
          :invitee_id,
          :booking_id,
          )
      end
    end
  end
end
