class HomeController < ApplicationController
  def index
    if user_signed_in?
      @user = User.find(current_user.id)
      @fan = []
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

      Band.all.each do |band|
        @fan << band unless band.fans.where(:id => current_user.id).empty?
      end
    end
  end

  private

  def push_concerts(concerts, role, perf)
    concert = Concert.where(:id => perf.concert_id).where('from_date >= ?', DateTime.current)
    unless concert.empty?
      concerts << []
      concerts[concerts.length-1] << Band.where(:id => role.band_id)
      concerts[concerts.length-1] << concert
    end
  end
end
