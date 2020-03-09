# frozen_string_literal: true

module Api
  module V1
    class BookingsController < ApplicationController
      # you can find these includes in controllers/concerns
      include Response
      include ExceptionHandler

      def index
        if params[:room_id].present?
          @bookings = Booking.where(room_id: params[:room_id])
          @bookings.sort_by {|t| t.id}
          json_response(@bookings)
        else
          @bookings = Booking.all
          json_response(@bookings)
        end
      end

      def show
        if params[:room_id].present?
          @booking = Booking.find_by(room_id: params[:room_id],id: params[:id])
          # @participants = Participant.where(booking_id: params[:id])
          # @booking.participants = @participants
          authorize @booking
          json_response(@booking)
        else
          @booking = Booking.find_by(id: params[:id])
          authorize @booking
          json_response(@booking)
        end
      end

      def create
        @booking = Booking.new(booking_params)
        @booking.user = current_user

        if @booking.save!
          authorize @booking
          json_response(@booking)
        end
      end

      def update
        @booking = Booking.find_by(room_id: params[:room_id],id: params[:id])
        @booking.update_attributes(booking_params)
        authorize @booking
        json_response(@booking)
      end

      def destroy
        if params[:room_id].present?
          @booking = Booking.find_by(room_id: params[:room_id],id: params[:id])
          authorize @booking
          @booking.destroy!
        else
          @booking = Booking.find_by(id: params[:id])
          authorize @booking
          @booking.destroy!
        end
      end

      private

      def booking_params
        params.permit(
          :start_time,
          :end_time,
          :date,
          :room_id
          )
        # Write your code here
      end
    end
  end
end
