class User < ActiveRecord::Base
  self.per_page = 20
  before_save :nil_if_blank_fullname
  validates :username, :presence => true, :uniqueness => { :case_sensitive => false }
  validate :validate_username

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :authentication_keys => [:login]
  attr_accessor :login

  has_many :band_roles
  has_many :bands, through: :band_roles

  has_many :comments, :dependent => :destroy

  has_and_belongs_to_many :favourite_bands, :class_name=>'Band', :join_table => 'bands_users',
                          :foreign_key => :user_id, :association_foreign_key => :band_id

  def username_and_email
    "#{username} - (#{email})"
  end

  def pretty_name
    fullname || username || email
  end

  def unconfirmed_concerts
    result = bands.map do |band|
      next if band.unconfirmed_upcoming_concerts.empty?
      band.unconfirmed_upcoming_concerts.map do |concert|
        [concert, band]
      end
    end

    result.flatten(1).reject(&:nil?)
  end

  def confirmed_concerts
    result = bands.map { |band| band.confirmed_upcoming_concerts }.flatten.uniq

    result
  end

  def favourite_bands_confirmed_concerts
    result = favourite_bands.map { |band| band.confirmed_upcoming_concerts }.flatten.uniq

    result
  end

  # RailsAdmin config
  rails_admin do
    object_label_method do
      :username_and_email
    end

    list do
      include_fields :username, :email, :fullname
    end

    show do
      include_fields :username, :email, :fullname, :bands, :favourite_bands
    end
  end

  # Devise additional config
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_hash).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_hash).first
    end
  end

  private

  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end

  def nil_if_blank_fullname
    self[:fullname] = nil if self[:fullname].blank?
  end
end
