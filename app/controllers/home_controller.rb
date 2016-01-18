class HomeController < ApplicationController
  def index
    @user = User.where(:id => current_user.id)[0] if user_signed_in?
  end
end
