# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
s1 = Status.create(name: 'Pasivo')
ch1 = Church.create(name: 'Asamblea de Dios Autónoma', adress: 'J.M. de Rosas 1154',
                    email: 'raul.torres.calistro@gmail.com', phone: 11151515 )

ch2 = Church.create(name: 'Presbiteriana', adress: 'Luis Araneda 2323',
                    email: 'presbiteriana@gmail.com', phone: 11991515 ) 
10.times do |u|
  Member.create(name: Faker::Name.name, email: Faker::Internet.email, adress: Faker::Address.street_address,
  phone: Faker::Number.number(8), status: s1, church: ch1 )
end
15.times do |u|
  Member.create(name: Faker::Name.name, email: Faker::Internet.email, adress: Faker::Address.street_address,
  phone: Faker::Number.number(8), status: s1, church: ch2 )
end