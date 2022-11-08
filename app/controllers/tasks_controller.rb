class TasksController < ApplicationController

  def index
    @tasks = Task.all # Adds all the tasks to one var
  end

  def show
    @task = Task.find(params[:id]) # Fetches the task with the id that matches and adds to a var
  end

  def new
    @task = Task.new # Creates a new task instance and assigns it to a var
  end

  def create
    @task = Task.new(task_params) # Creates a new instance with the data from user
    if @task.save # if save to db is successful
      redirect_to task_path(@task) # redirect to the page with the new task
    else # if save to db failed
      render :new, status: :unprocessable_entity # render the new task form with the error
    end
  end

  def edit
    @task = Task.find(params[:id]) # fetches the task to edit and show in form.
  end

  def update
    @task = Task.find(params[:id]) # Creates a new instance with the data from user
    if @task.update(task_params) # if save to db is successful
      redirect_to task_path(@task) # redirect to the page with the new task
    else # if save to db failed
      render :edit, status: :unprocessable_entity # render the new task form with the error
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path, status: :see_other
  end

  private

  def task_params
    params.require(:task).permit(:title, :details, :completed) # sets that fields is allowed to be sent/edited in the database
  end
end
