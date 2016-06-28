if Rails.env.development?
  church = Church.find_or_create_by!(
    name: 'Presbiteriana', email: Faker::Internet.email,
    address: Faker::Address.street_address, phone: Faker::Number.number(8)
  )

  user = User.new(
    name: 'Admin',email: 'admin@example.com', password: 'password',
    password_confirmation: 'password', church: church
  )
  user.role = :admin
  user.save

  responsibilities = []
  ['Profesor', 'Alumno Adolescente', 'Alumno Preadolescente', 'Alumno Iniciales'].each do |resp|
    responsibilities << Responsibility.create(
      name: resp, church: church, administrative: [true, false].sample
    )
  end

  ['Escuela Biblica', 'Grupo de Jovenes'].each do |min|
    Ministry.create(name: min, church: church, responsibilities: responsibilities )
  end

  20.times do |u|
    Member.create!(
      first_name: Faker::Name.first_name, last_name: Faker::Name.last_name,
      email: Faker::Internet.email, address: Faker::Address.street_address,
      phone: Faker::Number.number(8), status: Member.statuses.keys.sample,
      church: church, charges: Charge.order('RANDOM()').limit(rand(0..8))
    )
  end
end
