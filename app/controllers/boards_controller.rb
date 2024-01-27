class BoardsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  def index
  end

  def new
    @board = current_user.boards.build
  end

  def create
    @board = current_user.boards.build(board_params)
    if @board.save
    else
      render :new
    end
  end

  private
  def board_params
    params.require(:board).permit(:title, :content)
  end
end
