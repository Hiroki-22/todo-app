class TasksController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @board = Board.find(params[:board_id])
    @tasks = @board.tasks.all
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

  private
  def task_params
    params.require(:task).permit(:title, :content)
  end
end
