class AddValidationToUser < ActiveRecord::Migration
  def change
    add_column :users, :validation_code, :string, :default => nil
    add_column :users, :email_valid, :boolean, :default => 0
  end
end
