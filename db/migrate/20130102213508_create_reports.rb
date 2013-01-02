class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.integer :user_id
      t.integer :kind
      t.text :data

      t.timestamps
    end
  end
end
