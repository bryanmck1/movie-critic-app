class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin, only: [:new, :create, :edit, :update, :destroy]

  require 'http'
  require 'json' 
  
  def index
    @reviews = Review.select(:id, :movie_poster, :movie_title, :review_score).as_json
  end

  def show
    @review = Review.find(params[:id])
  end

  def new   
    @result = params[:imdb_id].present? ? JSON.parse(HTTP.get("https://www.omdbapi.com/?apikey=#{ENV['MOVIE_API_KEY']}&i=#{params[:imdb_id]}")) : []
  end

  def create 
    @review = Review.create(movie_poster: params[:poster], movie_title: params[:title], director: params[:director], writer: params[:writer], genre: params[:genre], runtime: params[:runtime], awards: params[:awards], rated: params[:rated], plot_summary: params[:summary], review_score: params[:score], review_summary: params[:review], release_year: params[:year], actors: params[:actors], imdb_id: params[:imdbID])
    if @review.save 
      redirect_to reviews_path 
    end
  end
  
  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    @review.update(review_score: params[:review][:score], review_summary: params[:review][:review])
    redirect_to review_path(@review) if @review.save
  end

  def destroy
    @review = Review.find(params[:id])
    redirect_to reviews_path if @review.destroy
  end

  def search
    @reviews = Review.select(:id, :movie_poster, :movie_title, :review_score).as_json
    @search_results = Review.select(:id, :movie_poster, :movie_title, :review_score).where("LOWER(movie_title) LIKE :query OR LOWER(release_year) LIKE :query OR LOWER(genre) LIKE :query OR LOWER(director) LIKE :query OR LOWER(writer) LIKE :query OR LOWER(actors) LIKE :query", query: "%#{params[:query].downcase.strip.squeeze(" ")}%").as_json
    respond_to do |format|
      format.turbo_stream { render :index }
      format.html { render :index }
    end
  end

  def filter 
    @reviews = Review.select(:id, :movie_poster, :movie_title, :review_score).as_json
    @filter_params = []  
    @filter_params << Review.select(:id, :movie_poster, :movie_title, :review_score).where(release_year: params[:release_year]).as_json if params[:release_year].present?
    @filter_params << Review.select(:id, :movie_poster, :movie_title, :review_score).where(rated: params[:rated]).as_json if params[:rated].present?
    @filter_params << Review.select(:id, :movie_poster, :movie_title, :review_score).where(review_score: params[:review_score]).as_json if params[:review_score].present?
    @filter_params << Review.select(:id, :movie_poster, :movie_title, :review_score).where(Array.new(params[:genre].size, "genre LIKE ?").join(" OR "), *params[:genre].map { |genre| "%#{genre}%" }).as_json if params[:genre].present?
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