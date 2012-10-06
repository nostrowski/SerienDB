class AddSeasontagFlagToTag < ActiveRecord::Migration
  def change
    add_column :tags, :seasontag, :boolean, :default => 0
  end
end
