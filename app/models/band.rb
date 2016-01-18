class Band < ActiveRecord::Base
  self.per_page = 12
  has_many :band_roles, :dependent => :destroy
  has_many :members, :through => :band_roles, :source => :user

  has_many :performers, :dependent => :destroy
  has_many :concerts, through: :performers

  has_and_belongs_to_many :fans, :class_name=>'User', :join_table => 'bands_users',
                          :foreign_key => :band_id, :association_foreign_key => :user_id

  accepts_nested_attributes_for :band_roles
  validates :title, :presence => true
  validates :title, :uniqueness => true
  validates :description, :presence => true
end
