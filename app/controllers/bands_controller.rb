class BandsController < ApplicationController
  before_action :set_band, only: [:show, :edit, :update, :destroy,
                                  :manage_fan, :create_member, :add_member]
  before_action :authenticate_user!, except: [:index, :show]
  load_and_authorize_resource

  # GET /bands
  # GET /bands.json
  def index
    @bands = Band.where("title LIKE ?", "%#{params[:search]}%" ).page(params[:page])
  end

  # GET /bands/1
  # GET /bands/1.json
  def show
    @is_fan = @band.fans.include? current_user if user_signed_in?
    random_fan_ids = @band.fans.collect { |fan| fan.id }.sort_by { rand }.slice(0, 6)
    @fans = User.where(:id => random_fan_ids)
  end

  # GET /bands/new
  def new
    @band = Band.new
    @band.band_roles.build
  end

  # GET /bands/1/edit
  def edit
  end

  # POST /bands
  # POST /bands.json
  def create
    @band = Band.new(band_params)

    respond_to do |format|
      if @band.save
        format.html { redirect_to @band, notice: 'Band was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /bands/1
  # PATCH/PUT /bands/1.json
  def update
    respond_to do |format|
      @band.header = nil if params[:remove_header]
      if @band.update(band_params)
        format.html { redirect_to @band, notice: 'Band was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /bands/1
  # DELETE /bands/1.json
  def destroy
    @band.destroy
    respond_to do |format|
      format.html { redirect_to bands_url, notice: 'Band was successfully destroyed.' }
    end
  end

  # GET /bands/1/add-member
  def add_member
    @band_role = BandRole.new
  end

  # POST /bands/1/add-member
  def create_member
    @band_role = BandRole.new(role_params)
    @band_role.band = @band
    respond_to do |format|
      if @band_role.save
        format.html { redirect_to edit_band_path(@band_role.band), notice: 'Band member was successfully added.' }
      else
        format.html { render :add_member }
      end
    end
  end

  # DELETE /bands/drop-member/1
  def destroy_member
    role = BandRole.find(params[:mid])
    band = role.band
    role.destroy
    respond_to do |format|
      format.html { redirect_to edit_band_path(band), notice: 'Band member was dropped.' }
    end
  end

  # POST /bands/1/fan
  def manage_fan
    if params[:is_fan]
      @band.fans << current_user
    else
      @band.fans.delete current_user
    end
    respond_to do |format|
      format.html { redirect_to @band, notice: params[:is_fan] ?
          'You are now a fan of this band.' : 'You are no longer a fan of the band.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_band
      @band = Band.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def band_params
      params.require(:band).permit(:title, :description, :active, :header, band_roles_attributes: [ :id, :role, :user_id ], genre_ids: [])
    end

    def role_params
      params.require(:band_role).permit(:role, :user_id)
    end
end
