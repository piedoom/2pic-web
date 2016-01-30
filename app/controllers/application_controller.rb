class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery except: :api

  before_filter :set_default_response_format

  private

  def set_default_response_format
    request.format = :json
  end

  def current_user
    User.find_by_key(request.headers[:key])
  end

end
