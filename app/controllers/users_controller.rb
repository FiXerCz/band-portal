class UsersController < ApplicationController
  def index
    @users = User.paginate(:page => params[:page])
  end

  def show
    @user = User.find(params[:id])
    @users_bands = BandRole.where(:user_id => @user.id).select(:band_id)
    @uncorfimed_concerts = []
    @users_bands.each do |role|
      @performers = Performer.where(:band_id => role.band_id, :confirmed => false).each do |perf|
        @uncorfimed_concerts << []
        @uncorfimed_concerts[@uncorfimed_concerts.length-1] << Band.where(:id => role.band_id)
        @uncorfimed_concerts[@uncorfimed_concerts.length-1] << Concert.where(:id => perf.concert_id)
      end
    end
  end
end
