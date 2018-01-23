class TasksController < ApplicationController
  # before_action :authenticate_user!
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all

    respond_to do |format|
      format.json { render json: @tasks}
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        # format.html { redirect_to @task }
        format.json { render json: @task, status: :ok }
      else
        # format.html { render :new }
        format.json { render json: { errors: @task.errors.full_messages }, status: 422 }
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    if @task.destroy
      respond_to do |format|
        format.html { redirect_to tasks_path }
      end
    end
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :priority, :due_date, :user_id)
  end













end
