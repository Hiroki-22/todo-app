class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_board_and_task

  def new
    @comment = @task.comments.build
  end

  def create
    @comment = @task.comments.build(comment_params)
    @comment.user_id = current_user.id # コメントのuser_idフィールドに現在のユーザーのIDを設定しています。
    if @comment.save
      redirect_to board_task_path(board_id: @board.id, id: @task.id), notice: 'コメントを投稿しました'
    else
      flash.now[:error] = 'コメントの投稿に失敗しました'
      render :new
    end
  end

  private
  def set_board_and_task
    @board = Board.find(params[:board_id])
    @task = @board.tasks.find(params[:task_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
