class HomeController < ApplicationController
  before_action :authenticate_user!, only: [:notifications]

  def index
  end

  def notifications
  end
end
