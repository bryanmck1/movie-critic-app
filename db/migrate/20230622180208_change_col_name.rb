class ChangeColName < ActiveRecord::Migration[7.0]
  def change
    rename_column :reviews, :rating, :rated 
  end
end
