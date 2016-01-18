class ConcertsController < ApplicationController
  before_action :set_concert, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  load_and_authorize_resource

  def index
    @concerts = Concert.paginate(:page => params[:page]).order('from_date DESC')
  end

  def show
    @performers = Performer.where(:concert_id => @concert.id)

    @bands = []
    @confirmed_bands = []
    Performer.where(:concert_id => @concert.id).each do |p|
      band = Band.where(:id => p.band_id)
      @bands.push(band)
      @confirmed_bands.push(band) if p.confirmed
    end
  end

  def edit
    @concert = Concert.find(params[:id])
  end

  def new
    @concert = Concert.new
  end

  def create
    @concert = Concert.new(concert_params)
    @concert.user_id = current_user.id
    respond_to do |format|
      if @concert.save
        set_performers
        format.html { redirect_to @concert, notice: 'Concert was successfully created.' }
        format.json { render :show, status: :created, location: @concert }
      else
        format.html { render :new }
        format.json { render json: @concert.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @concert.update(concert_params)
        delete_performers
        set_performers
        format.html { redirect_to @concert, notice: 'Concert was successfully updated.' }
        format.json { render :show, status: :ok, location: @concert }
      else
        format.html { render :edit }
        format.json { render json: @concert.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @concert.destroy
    delete_performers
    respond_to do |format|
      format.html { redirect_to concerts_url, notice: 'Concert was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def confirm
    @performer = Performer.find(params[:performer][:id])
    respond_to do |format|
      if @performer.update(performer_params)
        format.html { redirect_to @concert, notice: 'Your concert attendance was successfully updated.' }
        format.json { render :show, status: :created, location: @concert }
      else
        format.html { render :show }
        format.json { render json: @concert.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_concert
    @concert = Concert.find(params[:id])
  end

  def concert_params
    params.require(:concert).permit(:title, :location, :capacity, :from_date, :to_date, :price, :performing_bands => [])
  end

  def performer_params
    params.require(:performer).permit(:confirmed)
  end

  def delete_performers
    Performer.where(concert_id: @concert.id).each do |perf|
      Performer.destroy(perf)
    end
  end

  def set_performers
    unless bands = params[:performing_bands]
      return false
    end
    bands.each do |band|
      Performer.where(concert_id: @concert.id, band_id: band.to_i).create
    end
  end
end
