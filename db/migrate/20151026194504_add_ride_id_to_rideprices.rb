class AddRideIdToRideprices < ActiveRecord::Migration
  def change
  	add_reference :rideprices, :ride, index: true, foreign_key: true
  end
end
