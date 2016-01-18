class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :create, :read, :update, :destroy, :to => :crud
    if user.nil?
      # define abilities of guest (not logged in)
      can :read, [Band, Concert, User]
    elsif !user.nil? && user.admin?
      # define abilities of portal admin
      can :manage, :all
      # can :access, :rails_admin
      # can :dashboard
    else
      #  define abilities of a regular signed in user
      can [:read, :create], [Band, Concert]
      set_users_advanced_band_perm user
      can [:update, :destroy], Concert, :user_id => user.id
      can [:update, :destroy], User, :id => user.id
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
end
