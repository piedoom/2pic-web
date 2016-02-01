class UsersController < ApplicationController

  before_filter :get_user, only: [:show]

  # VERY SECURE AUTHENTICATION
  # NSA RECOMMENDED

  def log_in
    user = User.find_by_username(params[:username].downcase)
    if user
      redirect_to "/users/#{user.id}"
    else
      redirect_to root_path
    end

    # oh god why
  end

  def show
    @photos = Photo.where(target_user: @user)
  end

  private

  def get_user
    @user = User.find(params[:id])
  end

end
