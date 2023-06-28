class Review < ApplicationRecord
  has_many :users

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
end 
 