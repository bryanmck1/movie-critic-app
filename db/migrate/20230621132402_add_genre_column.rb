class AddGenreColumn < ActiveRecord::Migration[7.0]
  def change
        add_column :reviews, :genre, :string 
  end
end
