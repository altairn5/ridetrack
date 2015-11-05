class RidesController < ApplicationController
before_action :right_user

  def index

  end
  
  def new
  	@user = current_user
    @token = ENV["UBER_SERVICE_TOKEN"]
  	@ride = Ride.new
  end

  def show
  	@ride = Ride.find(params[:id])
  	@origin = @ride[:origin]
  	@destination = @ride[:destination]
  end


  def create
    @user = current_user
    ride_params = params.require(:ride).permit(:origin, :destination, :created_at, :updated_at, :origin_latitude, :origin_longitude ,:destination_latitude ,:destination_longitude ,:ride_name)
  	@ride = Ride.new(ride_params)
    @ride.user = current_user
  	if @ride.save 
  		redirect_to ride_path(@ride.id)
  	else
  	redirect_to new_ride_path
  	end
  end
end

