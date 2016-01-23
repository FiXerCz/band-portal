class UsersController < ApplicationController
  def index
    @users = User.where("username LIKE ?", "%#{params[:search]}%" ).page(params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

end
