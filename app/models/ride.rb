class Ride < ActiveRecord::Base
	belongs_to :user
	has_many :rideprices


end
