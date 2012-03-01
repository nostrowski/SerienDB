class CreateSeasons < ActiveRecord::Migration
  def change
    create_table :seasons do |t|
      t.integer :series_id
      t.integer :number
      t.integer :added_by
      t.integer :edit_by

      t.timestamps
    end
  end
end
