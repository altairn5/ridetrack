class SitesController < ApplicationController
   before_action :current_user

   def index
	 	@user = User.new
	 	@disable_nav = true
	 	render :index
  end
end
 