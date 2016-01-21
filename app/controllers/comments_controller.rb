class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  def new
    @comment = Comment.new
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.band_id = params[:id]
    respond_to do |format|
      if @comment.save
        format.html { redirect_to band_path(params[:id], tab:"comments"), notice: 'Comment was successfully posted.' }
        format.json { render :show, status: :created, location: band_path(params[:id], tab:"comments") }
      else
        format.html { redirect_to band_path(params[:id], tab:"comments"), alert: 'Comment couldn\'t be posted - coment text cannot be empty.' }
        format.json { render json: band_path(params[:id], tab:"comments").errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to band_path(params[:comment][:id], tab:"comments"), notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: band_path(params[:comment][:id], tab:"comments") }
      else
        format.html { render :edit }
        format.json { render json: band_path(params[:comment][:id], tab:"comments").errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    band_id = @comment.band_id
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to band_path(band_id, tab:"comments"), notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end

