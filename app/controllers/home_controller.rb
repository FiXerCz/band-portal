class HomeController < ApplicationController
  def index
    if user_signed_in?
      @user = User.where(:id => current_user.id)[0]
      @user = User.find(current_user.id)
      @users_bands = BandRole.where(:user_id => @user.id).select(:band_id)
      @uncorfimed_concerts = []
      @corfimed_concerts = []
      @users_bands.each do |role|
        @performers = Performer.where(:band_id => role.band_id).each do |perf|
          if perf.confirmed
            push_concerts(@corfimed_concerts, role, perf)
          else
            push_concerts(@uncorfimed_concerts, role, perf)
          end
        end
      end
    end
  end

  private

  def push_concerts(concerts, role, perf)
    concerts << []
    concerts[concerts.length-1] << Band.where(:id => role.band_id)
    concerts[concerts.length-1] << Concert.where(:id => perf.concert_id)
  end
end
