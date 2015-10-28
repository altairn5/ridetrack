class RidesController < ApplicationController
before_action :current_user

  def index

  end
  
  def new
  	@user = current_user
  	@ride = Ride.new
  end

  def show
  	@ride = Ride.find(params[:id])
  	@origin = @ride[:origin]
  	@destination =@ride[:destination]
  end


  def create
  	@user = current_user
  	@ride = Ride.new
  	if @ride.save 
  		redirect_to ride_path(params[:id])
  	else
  	redirect_to new_ride_path
  	end
  end
end

