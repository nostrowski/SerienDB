class AddFilterrelationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :filterrelation, :string, :default => "and"
  end
end
