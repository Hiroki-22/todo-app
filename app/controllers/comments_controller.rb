class CommentsController < ApplicationController
  def new
    board = Board.find(params[:board_id])
    task = board.tasks.find(params[:task_id])
    @comment = current_user.comments.build(task_id: task.id)
  end
end
