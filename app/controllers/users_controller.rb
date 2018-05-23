class UsersController < ApplicationController
#may19 2018
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  #before_action :logged_in_user, only: [:index, :edit, :update]
  #before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update] 

    before_action :admin_user,     only: :destroy

  
   def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end



  def index
   #@users = User.all
   # @users = User.paginate(page: params[:page])

   #ted may 23 2018  true FILLED IN
   @users = User.where(activated: true).paginate(page: params[:page])
  end 

 

def new
    #added--ted to start signupp from
    @user = User.new
  end
  

  #may 17 2018--to show email at /users/1 via the browser
  def show
    @user = User.find(params[:id])
    
    #may 23 2018       FILLED IN
    redirect_to root_url and return unless @user.activated?


    #nice debudder--lik ende c code  ctrl+d makes it run again--ted
    #debugger
  end

  #ted ---to handle sih=gnup failure
  def create
    @user = User.new(user_params)   #xyz
   # @user = User.new(params[:user])    # Not the final implementation!
    if @user.save
     #ted may 23 2018
      @user.send_activation_email

      #ted may 23 2018
      #UserMailer.account_activation(@user).deliver_now
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
      #ted may 23 2018

     



      #log_in @user
      # Handle a successful save.
      #added  
      #flash[:success] = "Welcome to the Sample App!"
      #redirect_to @user

    else
      render 'new'
    end
  end

  #may 19 2018
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      # Handle a successful update.
       flash[:success] = "Profile updated"
      redirect_to @user

    
    else
      render 'edit'
    end
  end


  
  #added  with xyz above
  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    #added  may 19 2018
    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
       
       store_location
       
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
       redirect_to(root_url) unless current_user?(@user)
      #redirect_to(root_url) unless @user == current_user
    end

   # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end



end
