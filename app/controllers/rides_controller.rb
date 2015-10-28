class RidesController < ApplicationController
before_action :current_user

  def index

  end
  
  def new
  	@user = current_user
  	@ride = Ride.new
  end

  def show
  end


  def create
  	@user = current_user
  	@ride = Ride.new
  	if @ride.save 
  		redirect_to user_path(session[:user_id])
  	else
  	redirect_to new_ride_path
  	end
  end
end

