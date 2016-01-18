class User < ActiveRecord::Base
  self.per_page = 20
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :authentication_keys => [:login]
  attr_accessor :login

  has_many :band_roles
  has_many :bands, through: :band_roles

  has_and_belongs_to_many :favourite_bands, :class_name=>'Band', :join_table => 'bands_users',
                          :foreign_key => :user_id, :association_foreign_key => :band_id

  validates :username, :presence => true, :uniqueness => { :case_sensitive => false }
  validate :validate_username

  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end

  def username_and_email
    "#{username} - (#{email})"
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_hash).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_hash).first
    end
  end
end
