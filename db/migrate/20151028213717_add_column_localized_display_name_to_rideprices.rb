class AddColumnLocalizedDisplayNameToRideprices < ActiveRecord::Migration
  def change
  	add_column :rideprices, :uber_ride_name ,:string

  end
end
