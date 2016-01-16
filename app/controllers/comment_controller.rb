class CommentController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  def new
    @comment = Comment.new
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def create
    @comment = Comment.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment, notice: 'Band was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
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

