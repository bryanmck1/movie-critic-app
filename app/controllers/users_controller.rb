class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user, only: [:show]

  def show
    if flash.now[:access_denied].present?
      flash.now[:access_denied] = flash.now[:access_denied]
      redirect_to user_path(current_user)
    end
  end

  private

  def authorize_user
    if current_user.id != params[:id].to_i
      flash[:access_denied] = "You are not authorized to view that page."
      redirect_to user_path(current_user), flash: { access_denied: flash[:access_denied] }
    end
  end
end