class TasksController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_task, only: %i[edit update destroy update_task_status]

  def index
    @tasks = Task.all
    authorize @tasks
  end

  def new
    @task = Task.new
    authorize @task
  end

  def create
    @task = Task.new(task_params)
    authorize @task

    if @task.save
      respond_to do |format|
        format.html { redirect_to root_path }
        format.turbo_stream
      end
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def destroy
    @task.destroy

    respond_to do |format|
      format.html { redirect_to root_path }
      format.turbo_stream
    end
  end

  def update_task_status
    @task.update(is_completed: params[:is_completed])
    redirect_to root_path
  end

  private

    def set_task
      @task = Task.find_by(id: params[:id])
      authorize @task
    end

    def task_params
      params.require(:task).permit(:name, :description, :user_id)
    end
end
