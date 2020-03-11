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
          @bookings.each do |booking|
            @data = []
            @participants = Participant.where(booking_id: booking.id).count
            booking.participant_count = @participants
            @data.push(booking)
          end
          json_response(@bookings.sort_by{|booking| booking.id})
        else
          @bookings = Booking.all
          @bookings.each do |booking|
            @data = []
            @participants = Participant.where(booking_id: booking.id).count
            booking.participant_count = @participants
            @data.push(booking)
          end
          json_response(@bookings.sort_by{|booking| booking.id})
        end
      end

      def show
        if params[:room_id].present?
          @booking = Booking.find_by(room_id: params[:room_id],id: params[:id])
          @participants = Participant.where(booking_id: params[:id]).count
          @booking.participant_count = @participants
          authorize @booking
          json_response(@booking)
        else
          @booking = Booking.find_by(id: params[:id])
          @participants = Participant.where(booking_id: params[:id]).count
          @booking.participant_count = @participants
          authorize @booking
          json_response(@booking)
        end
      end

      def create
        @booking = Booking.new(booking_params)
        @booking.user = current_user
        @participants = Participant.where(booking_id: @booking.id).count
        @booking.participant_count = @participants

        if @booking.save!
          authorize @booking
          json_response(@booking)
        end
      end

      def update
        @booking = Booking.find_by(room_id: params[:room_id],id: params[:id])
        @participants = Participant.where(booking_id: params[:id]).count
        @booking.participant_count = @participants
        if @booking.update_attributes!(booking_params)
          authorize @booking
          json_response(@booking)
        end
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
          :room_id,
          :participant_count
        )

      end
    end
  end
end
