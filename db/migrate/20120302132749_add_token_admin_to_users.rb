class AddTokenAdminToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_admin, :boolean, :default => 0
  end
end
