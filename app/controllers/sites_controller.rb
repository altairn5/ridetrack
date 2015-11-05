class SitesController < ApplicationController
   def index
	 	@user = User.new
	 	@disable_nav = true
	 	render :index
  end
end
 