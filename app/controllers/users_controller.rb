class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user, only: [:show, :update]

  def show
    if flash.now[:access_denied].present?
      flash.now[:access_denied] = flash.now[:access_denied]
      redirect_to user_path(current_user)
    end
  end

  def index
  end

  def reset_password
    puts "RESET"
    @user = User.find(params[:email])
    @user.send_reset_password_instructions
  end

  def edit     
  end

  private

  def authorize_user
    if current_user.id != params[:id].to_i
      flash[:access_denied] = "You are not authorized to view that page."
      session[:access_denied_message] = flash[:access_denied]
      redirect_to root_path
    end
  end
end