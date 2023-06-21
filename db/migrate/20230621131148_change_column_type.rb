class ChangeColumnType < ActiveRecord::Migration[7.0]
  def change
    change_column :reviews, :genre, :json, default: []
  end
end
