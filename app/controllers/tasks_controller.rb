class TasksController < ApplicationController

  before_action :require_user_logged_in, only: [:index, :show, :edit, :new]
  before_action :correct_user, only: [:destroy, :show, :update, :edit]
  before_action :set_task, only: [:show, :edit, :update, :destroy]


  def index

    @tasks = current_user.tasks

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

  def new

    @task = Task.new

  end

  def edit

  end

  def show


  end

  def update
    if @task.update(task_params)
      flash[:success] = "タスク内容は正常に更新されました"
      redirect_to @task
    else
      flash.now[:danger] = "タスク内容は正常に更新されませんでした"
      render :edit

    end 

  end

  def destroy

    @task.destroy

    flash[:success] = "タスクは正常に削除されました"
    redirect_to tasks_url

  end

  private

  # tasks_controller.rb内の@task = Task.find(params[:id])の部分テンプレート(パーション)

  def set_task

    @task = Task.find(params[:id])

  end    

  #Strong parameter

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