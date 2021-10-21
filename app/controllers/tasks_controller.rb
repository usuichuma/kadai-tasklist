class TasksController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :new, :edit]
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
      redirect_to @task
    else
      flash[:danger] = 'タスクが投稿されません'
      render :new
    end
  end
  
  def edit
  end
  
  def update
    
    if @task.update(task_params)
      flash[:success] = 'タスクが編集されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクが編集されませんでした'
      render :edit
    end  
  end
  
  def destroy
    @task.destroy
    
    flash[:success] = 'タスクが削除されました'
    redirect_to tasks_path  
  end

private

def set_task
  @task = current_user.tasks.find(params[:id])
end

# Strong Parameter
def task_params
  params.require(:task).permit(:content, :status)
end
end