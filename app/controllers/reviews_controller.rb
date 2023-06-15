class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user, only: [:index] 
  before_action :check_admin, only: [:new, :create, :edit, :update, :destroy]

  require 'http'
  require 'json'
  
  def index
  end
  
  def new
   
      if params[:movie_query].present? 
        movie = params[:movie_query]
        api_key = "d76f5007"
        movie_api = "https://www.omdbapi.com/?apikey=#{api_key}&s=#{movie}"
        response = HTTP.get(movie_api) 
        json = JSON.parse(response)
        puts json['Search']
        @results = json['Search']
      else
          @results = []
      end 
  end

  private

  def authorize_user
    unless user_signed_in?
    flash[:access_denied] = "You must be logged in to view this page."
    session[:access_denied_message] = flash[:access_denied]
    redirect_to root_path
    end
  end

  def check_admin
    unless current_user.admin?
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to user_path(current_user)
    end
  end
end