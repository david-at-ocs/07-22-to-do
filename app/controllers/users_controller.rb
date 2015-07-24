class UsersController < ApplicationController




  def verify_login
    attempted_password = params[:user][:password]
    @users = User.where("email" => params[:user][:email])
    actual_password = BCrypt::Password.new(@users[0].password)
    session[:user_id] = @users[0].id
    if actual_password == attempted_password
      redirect_to profile_path # user_path(@users[0].id)
    else
      render login_path
    end
  end
 
  def logout
    session.clear
    redirect_to login_path
  end
  
  def index
    @users = User.all
  end
  
  def show    
    @user = User.find(session[:user_id])
  end
  
  
  
  
  # Gets the form to eidt user
  def edit
    @user = User.find(params[:id])
  end
  
  # Proccesses the edit user form params
  def update
    @user = User.find(params[:id])
    
    if @user.update_attributes(user_params)
      redirect_to profile_path
    else
      render "edit"
    end
  end
  
  

  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end
  
  
  
  
  
  # Gets the form to create user
  def new
    @user = User.new
  end
  
  # Proccesses the new user form params
  def create
    @user = User.new(user_params)
    @user.encrypt_password(user_params[:password])
    # session[user] = @users[0].id
    if @user.save
      session[:user_id] = @user.id
      redirect_to profile_path #user_path(session[:user_id])
    else
      render users_path
    end
  end
  
  private
  
  
  def current_user
    if session[:user_id]
      @current_user = User.find(session[:user_id])
    else
      redirect_to login
    end
  end
  
  def user_params
    params[:user].permit(:name, :email, :password)
  end
  
end
