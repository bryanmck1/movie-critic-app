class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin, only: [:new, :create, :edit, :update, :destroy]

  require 'http'
  require 'json' 
  
  def index
    @reviews = Review.all 
  end

  def new   
    if params[:imdb_id].present? 
      movie = params[:imdb_id]
      api_key = ENV["MOVIE_API_KEY"]
      movie_api = "https://www.omdbapi.com/?apikey=#{api_key}&i=#{movie}"
      response = HTTP.get(movie_api) 
      @result = JSON.parse(response)
    else
      @result = []
    end 
  end

  def create 
    @review = Review.create(movie_poster: params[:poster], movie_title: params[:title], director: params[:director], writer: params[:writer], genre: params[:genre], runtime: params[:runtime], awards: params[:awards], rated: params[:rated], plot_summary: params[:summary], review_score: params[:score], review_summary: params[:review], release_year: params[:year], actors: params[:actors], imdb_id: params[:imdbID])
    if @review.save 
      redirect_to reviews_path 
    end
  end

  def show
    @review = Review.find(params[:id])
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

  def destroy
    @review = Review.find(params[:id])
    @review.destroy 
    if @review.destroy 
      redirect_to reviews_path
    end
  end

  def search
    @reviews = Review.all
    @search_results = Review.where("LOWER(movie_title) LIKE :query OR LOWER(release_year) LIKE :query OR LOWER(genre) LIKE :query OR LOWER(director) LIKE :query OR LOWER(writer) LIKE :query OR LOWER(actors) LIKE :query", query: "%#{params[:query].downcase.strip.squeeze(" ")}%")
    render :index 
  end

  def filter 
    @reviews = Review.all  
    @filter_params = []  
    @filter_params << Review.where(release_year: params[:release_year]) if params[:release_year].present?
    @filter_params << Review.where(rated: params[:rated]) if params[:rated].present?
    @filter_params << Review.where(review_score: params[:review_score]) if params[:review_score].present?
    if params[:genre].present?
      genres = params[:genre]
      query = Array.new(genres.size, "genre LIKE ?").join(" OR ")
      @filter_params << Review.where(query, *genres.map { |genre| "%#{genre}%" })
    end
    @filter_params = @filter_params.flatten.uniq
    @params_exist = params[:release_year].present? || params[:genre].present? || params[:rated].present? || params[:review_score].present? 
    
   
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
        'reviews_frame',
        partial: 'movie_layout',
        locals: { reviews: @filter_params }
      )
      end
      format.html { render :index }
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