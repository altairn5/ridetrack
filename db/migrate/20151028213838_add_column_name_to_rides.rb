class AddColumnNameToRides < ActiveRecord::Migration
  def change
  	add_column :rides, :ride_name, :string
  end
end
