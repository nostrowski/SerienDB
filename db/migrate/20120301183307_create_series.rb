class CreateSeries < ActiveRecord::Migration
  def change
    create_table :series do |t|
      t.string :name
      t.integer :added_by
      t.integer :edit_by

      t.timestamps
    end
  end
end
