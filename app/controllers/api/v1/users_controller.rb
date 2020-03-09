# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :authorize_request, only: :create

      # you can find these includes in controllers/concers
      include Response
      include ExceptionHandler

      def index
       @user = current_user
       json_response(@user)
     end


     def create
      @user = User.create!(user_params)
      authorize @user
      auth_token = AuthenticateUser.new(@user.email, @user.password).call
      response = { message: Message.account_created, auth_token: auth_token }
      json_response(response, :created)
    end

      private

      def user_params
        params.permit(
          :name,
          :email,
          :password,
          :password_confirmation
          )
      end
    end
  end
end

