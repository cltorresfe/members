# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

ch3 = Church.find_or_create_by!(name: 'Presbiteriana', email: Faker::Internet.email, address: Faker::Address.street_address, phone: Faker::Number.number(8))
r1= Responsibility.find_or_create_by(name: 'Profesor')
r2= Responsibility.find_or_create_by(name: 'Alumno Adolescente')
r3= Responsibility.find_or_create_by(name: 'Alumno Preadolescente')
r4= Responsibility.find_or_create_by(name: 'Alumno Iniciales')
20.times do |u|
  Member.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name email: Faker::Internet.email, address: Faker::Address.street_address,
  phone: Faker::Number.number(8), status: Member.statuses.keys.sample, church: ch3 )
end

user = User.new(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
user.role = :admin
user.save
