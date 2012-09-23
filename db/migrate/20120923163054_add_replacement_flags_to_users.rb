class AddReplacementFlagsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :replace_uncomplete_x, :boolean, :default => 0
    add_column :users, :replace_complete_x, :boolean, :default => 0
  end
end
