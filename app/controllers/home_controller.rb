class HomeController < ApplicationController
  def index
    @user = User.where(:id => current_user.id)[0]
  end
end
