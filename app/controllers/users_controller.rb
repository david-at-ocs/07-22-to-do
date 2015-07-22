class UsersController < ApplicationController
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  # Gets the form to create user
  def new
    @user = User.new
  end
  
  # Proccesses the new user form 
  def create 
    @user = User.new(params)
    
    if @user.save
      redirect_to "/users"
    else
      render "new"
    end
  end
  
end
