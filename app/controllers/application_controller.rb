# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :authorize_request, only: :authenticate

  include Pundit
  include Response
  include ExceptionHandler

  # called before every action on controllers
  before_action :authorize_request
  attr_reader :current_user
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  # after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  # Check for valid request token and return user
  def authorize_request
    @current_user = AuthorizeApiRequest.new(request.headers).call[:user]
  end

  def skip_pundit?
    params[:controller] =~ /(^(rails_)?admin)|(^authentication)/
  end


  def user_not_authorized(e)
    json_response({ message: e.message }, :not_found)
  end

end
