class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user, only: [:index, :search] 
  before_action :check_admin, only: [:new, :create, :edit, :update, :destroy, :search, :filter]

  require 'http'
  require 'json' 
  
  def index
    @reviews = Review.all 
  end

  def filter 
    # filter_reviews_path
    @reviews = Review.all 

    puts params
    if params[:release_year].present?
      @search_results = @reviews.where(release_year: params[:release_year])
    end

    if params[:genre].present?
      @search_results = @reviews.where(genre: params[:genre])
    end

    if params[:rating].present?
      @search_results = @reviews.where(rating: params[:rating])
    end

    if params[:review_score].present?
      @search_results = @reviews.where(review_score: params[:review_score])
    end

        @params_exist = true if params[:release_year].present? or params[:genre].present? or params[:rating].present? or params[:review_score].present?

    
    #@reviews = Review.where("release_year = ? OR genre = ? OR rating = ? OR review_score = ?", params[:release_year], params[:genre], params[:rating], params[:review_score])
    

    #puts params_exist  
    # if @params_exist == true 
    #   @search_results = @reviews.where(review_score: params[:review_score], release_year: params[:release_year], genre: params[:genre], rating: params[:rating])
    # end

    #@params_exist = true if params[:release_year].present? or params[:genre].present? or params[:rating].present? or params[:review_score].present?

    if @params_exist == true 
      puts "YES"
    end
    render :index
  end

  def search
    @reviews = Review.all
    #query = params[:query].downcase
    @search_results = Review.where("LOWER(movie_title) LIKE :query OR LOWER(release_year) LIKE :query OR LOWER(genre) LIKE :query OR LOWER(director) LIKE :query OR LOWER(writer) LIKE :query OR LOWER(actors) LIKE :query", query: "%#{params[:query].downcase.strip.squeeze(" ")}%")
    render :index 
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy 
    if @review.destroy 
      redirect_to reviews_path
    end
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    @review.review_score = params[:review][:score]
    @review.review_summary = params[:review][:review]
    if @review.save 
      redirect_to review_path(@review)
    end
  end

  def create 
    @review = Review.create(movie_poster: params[:poster], movie_title: params[:title], director: params[:director], writer: params[:writer], genre: params[:genre], runtime: params[:runtime], awards: params[:awards], rating: params[:imdbRating], plot_summary: params[:summary], review_score: params[:score], review_summary: params[:review], release_year: params[:year], actors: params[:actors], imdb_id: params[:imdbID])
    if @review.save 
      redirect_to reviews_path 
    end
  end
  
  def new   
    if params[:imdb_id].present? 
      movie = params[:imdb_id]
      api_key = "d76f5007"
      movie_api = "https://www.omdbapi.com/?apikey=#{api_key}&i=#{movie}"
      response = HTTP.get(movie_api) 
      json = JSON.parse(response)        
      @result = json
    else
      @result = []
    end 
  end

  def show
    @review = Review.find(params[:id])
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