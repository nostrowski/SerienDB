class AddPilotFlagToSeries < ActiveRecord::Migration
  def change
    add_column :series, :has_pilot, :boolean, :default => 0
  end
end
