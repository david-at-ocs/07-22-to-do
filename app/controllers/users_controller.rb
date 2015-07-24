class UsersController < ApplicationController




  def verify_login
    attempted_password = params[:user][:password]
    @users = User.where("email" => params[:user][:email])
    if !@users[0].nil?
      actual_password = BCrypt::Password.new(@users[0].password)
      if actual_password == attempted_password
        session[:user_id] = @users[0].id
        redirect_to profile_path # user_path(@users[0].id)
      else
        render login_path
      end
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
    if !session[:user_id].nil?
      @users = User.find(session[:user_id])
      @tasks = Task.where("user_id" => session[:user_id])
      profile_path
    else
      redirect_to login_path
    end
  end
  
  
  
  
  # Gets the form to eidt user
  def edit
    @users = User.find(params[:id])
  end
  
  # Proccesses the edit user form params
  def update
    @users = User.find(params[:id])
    
    if @users.update_attributes(user_params)
      redirect_to profile_path
    else
      render "edit"
    end
  end
  
  

  
  def destroy
    @users = User.find(params[:id])
    @users.destroy
    redirect_to users_path
  end
  
  
  
  
  
  # Gets the form to create user
  def new
    @users = User.new
  end
  
  # Proccesses the new user form params
  def create
    @users = User.new(user_params)
    @users.encrypt_password(user_params[:password])
    # session[user] = @users[0].id
    if @users.save
      session[:user_id] = @users.id
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
