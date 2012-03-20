class CreateSeriesTags < ActiveRecord::Migration
  def change
    create_table :series_tags, :id => false do |t|
      t.integer :series_id
      t.integer :tag_id
    end
  end
end
