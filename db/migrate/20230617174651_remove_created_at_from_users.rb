class RemoveCreatedAtFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :confirmed_at 
  end
end
