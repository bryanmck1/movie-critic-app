class MoviesController < ApplicationController
  before_action :check_admin, only: [:new]

  require 'http'
  require 'json'  

  def new
    @reviews = Review.all 
    if params[:movie_query].present? 
      movie = params[:movie_query] 
      api_key = "d76f5007"
      movie_api = "https://www.omdbapi.com/?apikey=#{api_key}&s=#{movie}"
      response = HTTP.get(movie_api) 
      json = JSON.parse(response)        
      @results = json['Search']
    else
      @results = []
    end 
  end

  private 
  
  def check_admin
    unless current_user.admin?
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to user_path(current_user)
    end
  end
end