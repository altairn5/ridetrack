class CreateRideprices < ActiveRecord::Migration
  def change
    create_table :rideprices do |t|
      t.integer :price
      t.integer :surge
      t.timestamp :time

      t.timestamps null: false
    end
  end
end
