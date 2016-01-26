class RidesController < ApplicationController
before_action :right_user

  def index
    @current_user = current_user
    #why find_by does not capture all
    # @rides = Ride.find_by(:user_id => current_user.id)
    @rides = Ride.all.where(:user_id => current_user.id)
   
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
    @ride_name = @ride[:ride_name]
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

  def edit
    ride_id = params[:id]
    @ride = Ride.find(ride_id) 

  end


  def update
    ride_id = params[:id]
    @ride = Ride.find(ride_id)
    params_updated = params.require(:ride).permit(:origin, :destination, :created_at, :updated_at, :origin_latitude, :origin_longitude ,:destination_latitude ,:destination_longitude ,:ride_name)
    @ride.update(params_updated)
    redirect_to ride_path

  end

end

