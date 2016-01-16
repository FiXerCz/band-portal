class ConcertsController < ApplicationController
  before_action :set_concert, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @concerts = Concert.all
  end

  def show

  end

  def edit
    @concert = Concert.find(params[:id])
  end

  def new
    @concert = Concert.new
  end

  def create
    @concert = Concert.new(comment_params)

    respond_to do |format|
      if @concert.save
        format.html { redirect_to @concert, notice: 'Band was successfully created.' }
        format.json { render :show, status: :created, location: @concert }
      else
        format.html { render :new }
        format.json { render json: @concert.errors, status: :unprocessable_entity }
      end
    end
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
