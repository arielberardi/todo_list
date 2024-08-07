class TasksController < ApplicationController
  before_action :set_task, only: [:edit, :update, :destroy, :toggle_status]

  def index
    @pagy, @tasks = pagy(Task.order(:created_at))
    @task = Task.new
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      respond_to do |format|
        format.html { redirect_to tasks_url, notice: "Task was successfully created." }
        format.turbo_stream
      end
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream { render  'create_error' }
      end
    end
  end

  def edit
  end

  def update
    @task.update(task_params)

    if @task.save
      respond_to do |format|
        format.html { redirect_to tasks_url, notice: "Task was successfully updated." }
        format.turbo_stream
      end
    else
      respond_to do |format|
        format.turbo_stream { render 'update_error' }
      end
    end
  end

  def destroy
    @task.destroy!

    respond_to do |format|
      format.turbo_stream
    end
  end

  def toggle_status
    @task.toggle_status!

    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title)
  end
end
