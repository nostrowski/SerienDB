class AddEpisodesCountToSeasons < ActiveRecord::Migration
  def change
    add_column :seasons, :episodes_count, :integer, :default => 0
  end
end
