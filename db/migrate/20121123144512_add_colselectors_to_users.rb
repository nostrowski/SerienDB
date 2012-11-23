class AddColselectorsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :show_ser_col_complete, :boolean, :default => 1
    add_column :users, :show_ser_col_uncomplete, :boolean, :default => 1
    add_column :users, :show_ser_col_seasoncount, :boolean, :default => 0
    add_column :users, :show_ser_col_episodecount, :boolean, :default => 0
    add_column :users, :show_sea_col_owner, :boolean, :default => 1
    add_column :users, :show_sea_col_episodecount, :boolean, :default => 1
  end
end
