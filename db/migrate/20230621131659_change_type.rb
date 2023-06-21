class ChangeType < ActiveRecord::Migration[7.0]
  def change
    remove_column :reviews, :genre
  end
end