class UsersController < ApplicationController
	before_action :logged_in?, only: [:show, :index]
  
  def index
  	@user = User.new
  	render :index
  end
  
  def new
  	@user = User.new
  	render :new
  end

  def create
  	  @user = User.new(user_params)
    if @user.save
       login(@user)
       redirect_to user_path(@user.id)
    else
      render :new
    end
  end
	 
	 def show
	 	@user = User.find(params[:id])
	 	@current_user = current_user
    @disable_nav = true
 	 end

 	 def edit
    @user = User.find(params[:id])
    render :edit
     end

  private
  def user_params
  	params.require(:user).permit(:first_name, :last_name, :email, :password, :age, :gender, :avatar)
  end


end
