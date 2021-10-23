class TasksController < ApplicationController
before_action :require_user_logged_in
before_action :correct_user, only: [:edit, :destroy, :update]
before_action :set_task, only: [:show, :edit, :update, :destroy]


  def index
    @tasks = current_user.tasks
  end

  def show
  end

  def new
    @task = Task.new  
  end
  
  def create
  @task = current_user.tasks.new(task_params)
    if @task.save
      flash[:success] = 'タスクが投稿されました'
      redirect_to tasks_url
    else
      flash[:danger] = 'タスクが投稿されません'
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @task.update(task_params)
      redirect_to tasks_url, notice: "タスク「#{@task.title}」を更新しました！"
    else
      render :edit
    end
  end
  
  def destroy
    @task.destroy
    redirect_to tasks_url, notice: "タスク「#{@task.title}」を削除しました。"
  end

private
  def set_task
    @task = current_user.tasks.find_by(id:params[:id])
  end
# Strong Parameter
  def task_params
  params.require(:task).permit(:content, :status)
  end
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
end