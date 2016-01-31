class AlbumsController < ApplicationController
  before_action :set_album, only: [:show, :edit, :update, :destroy, :display_image]
  before_action :authenticate_user!, except: [:index, :show, :display_image]
  load_and_authorize_resource :except => :display_image


  # GET /albums
  # GET /albums.json
  def index
    band = Band.find(params[:band_id])
    @albums = band.albums
  end

  # GET /albums/1
  # GET /albums/1.json
  def show
  end

  # GET /albums/new
  def new
    band = Band.find(params[:band_id])
    @album = band.albums.build
  end

  # GET /albums/1/edit
  def edit
  end

  def display_image
    style = params[:style] || 'original'
    send_data @album.image.file_contents(style), :type => @album.image_content_type, disposition: 'inline'
  end

  # POST /albums
  # POST /albums.json
  def create
    band = Band.find(params[:band_id])
    @album = band.albums.create(albums_no_songs_params)

    respond_to do |format|
      if @album.save
        save_albums_songs(album_params[:songs_attributes]) unless album_params[:songs_attributes].nil?
        format.html { redirect_to [@album.band, @album], notice: 'Album was successfully created.' }
        format.json { render :show, status: :created, location: [@album.band, @album] }
      else
        format.html { render :new }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /albums/1
  # PATCH/PUT /albums/1.json
  def update
    respond_to do |format|
      save_albums_songs(album_params[:songs_attributes]) unless album_params[:songs_attributes].nil?
      @album.image = nil if params[:remove_header]
      if @album.update(album_params)
        save_albums_songs(album_params[:songs_attributes]) unless album_params[:songs_attributes].nil?
        format.html { redirect_to [@album.band, @album], notice: 'Album was successfully updated.' }
        format.json { render :show, status: :ok, location: [@album.band, @album] }
      else
        format.html { render :edit }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /albums/1
  # DELETE /albums/1.json
  def destroy
    @album.destroy
    respond_to do |format|
      format.html { redirect_to band_albums_url, notice: 'Album was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_album
      band = Band.find(params[:band_id])
      @album = band.albums.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def album_params
      params.require(:album).permit(:title, :released, :image, songs_attributes: [:id, :done, :_destroy])
    end

    def albums_no_songs_params
      params.require(:album).permit(:title, :released, :image)
    end

    def save_albums_songs(songs_attributes)
      songs_attributes.each do |_, song_data|
        if song_data[:id] != "" && song_data[:_destroy] == "false"
          song = Song.find(song_data[:id])
          @album.songs << song unless @album.songs.include? song
        end
      end
    end
end
