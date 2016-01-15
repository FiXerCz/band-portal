class ConcertsController < ApplicationController
  #before_action :set_concert, only: [:show, :edit, :update, :destroy]

  def index
    @concerts = Concert.all
  end

  def show

  end

  def new
    @concert = Concert.new
  end

  def create

  end

  def update

  end

  def destroy

  end

  private

  def concert_params
    params.require(:post).permit(:location, :capacity, :from_date, :to_date, :price)
  end
end
