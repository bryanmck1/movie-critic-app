class Review < ApplicationRecord
  has_many :users
  require 'faker'

  # Adds movies from OMDB API
  def self.add_movies(movies_name) 
    api_key = ENV["MOVIE_API_KEY"]
    results = JSON.parse(HTTP.get("https://www.omdbapi.com/?apikey=#{api_key}&s=#{movies_name}"))['Search']
    
    imdb_ids = results.map { |movie| movie['imdbID'] }
    imdb_ids.each do |imdbID|  
      next if Review.exists?(imdb_id: imdbID)
      result = JSON.parse(HTTP.get("https://www.omdbapi.com/?i=#{imdbID}&apikey=#{api_key}"))
      review_score, review_summary = [rand(1..10), "Test review"]
      Review.create(movie_poster: result['Poster'], movie_title: result['Title'], director: result['Director'], writer: result['Writer'], genre: result['Genre'], runtime: result['Runtime'], awards: result['Awards'], rated: result['Rated'], plot_summary: result['Plot'], review_score: review_score, review_summary: review_summary, release_year: result['Year'], actors: result['Actors'], imdb_id: result['imdbID']) 
    end
  end

  # Can be used to add fictional movies with random data
  def self.fictional_movies
    poster = "https://picsum.photos/200"
    title = Faker::Movie.title
    director = Faker::Name.name
    writer = Faker::Name.name
    genre = ['Action', 'Comedy', 'Drama', 'Horror', 'Romance', 'Documentary', 'Crime', 'Western', 'Biography', 'Thriller', 'Animation', 'Adventure', 'Sports', 'Mystery', 'History', 'Music' ].sample
    runtime = rand(90..240).to_s + " min"
    awards = "Nominated for " + rand(5..15).to_s + "awards with " + rand(0..5).to_s + " wins"
    rated = ['PG-13', 'R', 'PG', 'TV-PG'].sample 
    summary = Faker::Lorem.paragraph
    review_score = rand(1..10)
    critic_review = Faker::Lorem.paragraph
    release_year = rand(1970..2023)
    actors = Array.new(10) { Faker::Name.name }.sample(rand(3..4))
    Review.create(movie_poster: poster, movie_title: title, director: director, writer: writer, genre: genre, runtime: runtime, awards: awards, rated: rated, plot_summary: summary, review_score: review_score, review_summary: critic_review, release_year: release_year, actors: actors, imdb_id: "false") 
  end
end 