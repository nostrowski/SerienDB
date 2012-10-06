class CreateSeasonsTags < ActiveRecord::Migration
  def change
    create_table :seasons_tags, :id => false do |t|
      t.integer :season_id
      t.integer :tag_id
    end
  end
end
