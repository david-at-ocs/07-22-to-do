class TasksController < ApplicationController
  
  def index
    @tasks = Task.all
  end
  
  def show
    @task = Task.find(params[:id])
  end
  
  
  
  
  # Gets the form to edit task
  def edit
    @task = Task.find(params[:id])
  end
  
  # Proccesses the edit task form params
  def update
    @task = Task.find(params[:id])
    
    if @task.update_attributes(task_params)
      redirect_to tasks_path
    else
      render "edit"
    end
  end
  
  

  
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path
  end
  
  
  
  
  
  # Gets the form to create task
  def new
    @task = Task.new
    @users = User.find(session[:user_id])
  end
  
  # Proccesses the new task form params
  def create
    @task = Task.new(task_params)
    binding.pry
    # if @task.save
    #   redirect_to tasks_path
    # else
    #   render "new"
    # end
  end
  
  
  
  private
  
  def task_params
    params[:task].permit(:name, :description, :completed, :user_id)
  end
  
end
