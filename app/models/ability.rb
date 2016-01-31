class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :create, :read, :update, :destroy, :to => :crud
    if user.nil?
      # define abilities of guest (not logged in)
      can :read, [Band, Concert, User, Album, Song]
    elsif !user.nil? && user.admin?
      # define abilities of portal admin
      can :manage, :all
      can :access, :rails_admin
      can :dashboard
    else
      #  define abilities of a regular signed in user
      can [:read, :create], [Band, Concert, Comment]
      can :read, [Album, Song]
      set_users_advanced_band_perm user
      set_users_advanced_album_song_perm user
      can [:update, :destroy], Concert, :user_id => user.id
      can [:update, :destroy], User, :id => user.id
      can [:confirm], Concert
      can [:update, :destroy], Comment, :user_id => user.id
    end
  end

  def set_users_advanced_band_perm(user)
    can [:update, :add_member, :create_member], Band do |band|
      band.members.include?(user)
    end
    can :destroy, Band do |band|
      band.members.size == 1 && band.members.include?(user)
    end
    can :destroy_member, Band do |band|
      # can kick member, if some member will remain in band after
      band.members.size > 1 && band.members.include?(user)
    end
    can :manage_fan, Band
  end

  def set_users_advanced_album_song_perm(user)
    can :create, Album do |album|
      user.bands.collect(&:id).include?(album.band_id)
    end
    can :create, Song do |song|
      user.bands.collect(&:id).include?(song.band_id)
    end
    can [:update, :destroy], Album do |album|
      album.band.members.include?(user)
    end
    can [:update, :destroy], Song do |song|
      song.band.members.include?(user)
    end
  end
end
