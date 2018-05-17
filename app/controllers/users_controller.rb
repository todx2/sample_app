class UsersController < ApplicationController
   def new
    #added--ted to start signupp from
    @user = User.new
  end
  

  #may 17 2018--to show email at /users/1 via the browser
  def show
    @user = User.find(params[:id])
    #nice debudder--lik ende c code  ctrl+d makes it run again--ted
    #debugger
  end

  #ted ---to handle sih=gnup failure
  def create
    @user = User.new(user_params)   #xyz
   # @user = User.new(params[:user])    # Not the final implementation!
    if @user.save
      # Handle a successful save.
      #added  
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user

    else
      render 'new'
    end
  end
  
  #added  with xyz above
  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end



end
