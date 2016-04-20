# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
s1 = Status.find_or_create_by(name: 'Pasivo')

ch3 = Church.find_or_create_by!(name: 'Presbiteriana', email: Faker::Internet.email, adress: Faker::Address.street_address, phone: Faker::Number.number(8))

10.times do |u|
  Member.create!(name: Faker::Name.name, email: Faker::Internet.email, adress: Faker::Address.street_address,
  phone: Faker::Number.number(8), status: s1, church: ch3 )
end

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
