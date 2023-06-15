class AddReviewsTable < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.timestamps 
      t.string "movie_poster"
      t.string "movie_title"
      t.string "director"
      t.string "writer"
      t.string "genre"
      t.string "runtime"
      t.string "awards"
      t.string "rating"
      t.string "plot_summary"
      t.integer "review_score"
      t.string "review_summary"

      t.integer "release_year"
    end 
  end
end