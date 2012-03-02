class AddTableOwners < ActiveRecord::Migration
  def change
    create_table :seasons_users, :id => false do |t|
      t.integer :season_id
      t.integer :user_id
    end
  end
end