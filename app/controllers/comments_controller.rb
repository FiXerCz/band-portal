class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  def new
    @comment = Comment.new
  end

  def edit
    @comment = Comment.find(params[:id]).page(params[:page])
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.band_id = params[:id]
    respond_to do |format|
      if @comment.save
        format.html { redirect_to band_path(params[:id]), notice: 'Comment was successfully posted.' }
        format.json { render :show, status: :created, location: band_path(params[:id]) }
      else
        format.html { redirect_to band_path(params[:id]), alert: 'Comment couldn\'t be posted - coment text cannot be empty.' }
        format.json { render json: band_path(params[:id]).errors, status: :unprocessable_entity }
      end
    end
  end

  def update

  end

  def destroy

  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
