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
User.create(:email => 'admin@admin.com', :password => 'password', :password_confirmation => 'password',
             :confirmation_token => 'umU7TefX37dqFE4MpMgn', :confirmed_at => '2016-01-01 00:00:00',
             :confirmation_sent_at => '2016-01-01 00:00:00', :unconfirmed_email => nil, :admin => true,
             :username => 'admin')

# Some randomly generated test users
['Steven Simons', 'Sylvia Stacy', 'Jules Fabron', 'Patrina Murton', 'Hank Janas', 'Cammie Plasencia', 'Mitsuko Voshell',
 'Charlott Beamon', 'Clemente Mary', 'Roberto Troiano', 'Jon Villano', 'Wade Lamoureaux', 'Myesha Sinegal',
 'Wyatt Mercedes', 'Arie Prichard', 'Vita Derosa', 'Jacquelin Locicero', 'Tisa Benner', 'Mauro Marotta', 'Claud Heger',
 'Vernita English', 'Justine Eich', 'Trevor Newman', 'Moses Newton', 'Wayne Brown', 'Micheal Casey', 'Lucas Mitchell',
 'Michelle Mckinney', 'Meghan Parker', 'Gail Duncan', 'Jeannette Sutton', 'Sheri Francis', 'Harold Cannon',
 'Floyd Kim'].each do |name|
  firstname = name.downcase.split(' ')[0]
  surname = name.downcase.split(' ')[1]
  email = firstname + '.' + surname +'@fakemail.tld'
  username = firstname[0] + surname

  User.create(:email => email, :password => 'password', :password_confirmation => 'password',
               :confirmation_token => 'umU7TefX37dqFE4MpMgn', :confirmed_at => '2016-01-01 00:00:00',
               :confirmation_sent_at => '2016-01-01 00:00:00', :unconfirmed_email => nil, :admin => false,
               :username => username, :fullname => name)
end
