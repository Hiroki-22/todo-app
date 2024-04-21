class TasksController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @board = Board.find(params[:board_id])
    @tasks = @board.tasks.all
  end

  def show
    @task = Task.find(params[:id])
    @comments = @task.comments
  end

  def new
    @task = current_user.tasks.build(board_id: params[:board_id])
  end

  def create
    @task = current_user.tasks.build(task_params)
    @task.board_id = params[:board_id]
    if @task.save
      redirect_to board_tasks_path(params[:board_id]), notice: '保存できました'
    else
      flash.now[:error] = '保存に失敗しました'
      render :new
    end
  end

  def edit
    @task = current_user.tasks.find(params[:id])
  end

  def update
    @task = current_user.tasks.find(params[:id])
    if  @task.update(task_params)
      redirect_to board_task_path(@task), notice: '更新できました'
    else
      flash.now[:error] = '更新できませんでした'
      render :edit
    end
  end

  def destroy
    task = current_user.tasks.find(params[:id])
    board = task.board
    task.destroy!
    redirect_to board_tasks_path(board), notice: '削除に成功しました'
  end

  private
  def task_params
    params.require(:task).permit(:title, :content, :eyecatch)
  end
end
