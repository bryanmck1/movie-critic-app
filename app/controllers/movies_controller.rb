class MoviesController < ApplicationController
  before_action :check_admin, only: [:new]

  require 'http'
  require 'json'  

  def new
    @reviews = Review.all 
    @results = params[:movie_query].present? ? JSON.parse(HTTP.get("https://www.omdbapi.com/?apikey=#{ENV['MOVIE_API_KEY']}&s=#{params[:movie_query]}"))['Search'] : []
  end

  private 
  
  def check_admin
    unless current_user.admin?
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to user_path(current_user)
    end
  end
end