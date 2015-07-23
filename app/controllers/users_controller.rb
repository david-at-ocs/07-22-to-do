class UsersController < ApplicationController
  
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  
  
  
  # Gets the form to eidt user
  def edit
    @user = User.find(params[:id])
  end
  
  # Proccesses the edit user form params
  def update
    @user = User.find(params[:id])
    
    if @user.update_attributes(user_params)
      redirect_to users_path
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
    
    if @user.save
      redirect_to users_path
    else
      render "new"
    end
  end
  
  private
  
  def user_params
    params[:user].permit(:name, :email, :password)
  end
  
end
