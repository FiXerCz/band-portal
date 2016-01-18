# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Basic genres
%w(Acoustic Alternative Blues Classical Country Electronic HipHop Instrumental Jazz Latin Metal Pop Rock Urban World).each do |g|
  Genre.create(title: g)
end

# Portal admin
User.create!(:email => 'admin@admin.com', :password => 'password', :password_confirmation => 'password',
             :confirmation_token => 'umU7TefX37dqFE4MpMgn', :confirmed_at => '2016-01-01 00:00:00',
             :confirmation_sent_at => '2016-01-01 00:00:00', :unconfirmed_email => nil, :admin => true,
             :username => 'admin')