class AddArrayToReviews < ActiveRecord::Migration[7.0]
  def change
            add_column :reviews, :actors, :json, default: []

  end
end
