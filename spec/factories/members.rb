# == Schema Information
#
# Table name: members
#
#  id              :integer          not null, primary key
#  first_name      :string
#  address         :string
#  email           :string
#  phone           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  church_id       :integer
#  status          :integer
#  run             :string
#  last_name       :string
#  gender          :boolean
#  city            :string
#  country         :string
#  testimony       :text
#  facebook        :string
#  twitter         :string
#  skype           :string
#  birth_date      :datetime
#  baptism_date    :datetime
#  membership_date :datetime
#  discipline_date :datetime
#  transfer_date   :datetime
#  avatar          :string
#  role            :integer
#  family_id       :integer
#

FactoryGirl.define do
  factory :member do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    address { Faker::Address.street_address }
    email { Faker::Internet.email }
    phone { Faker::PhoneNumber.phone_number }
    gender { [true, false].sample }
    status :active
    avatar { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'fixtures', 'user-m.png')) }
    run { Faker::Number.number(10) }
    city { Faker::Address.city }
    country 'CL'
    testimony { Faker::Lorem.sentence }
    facebook ''
    twitter ''
    skype { Faker::Internet.slug }
    birth_date { Faker::Date.between(10.years.ago, Date.today) }
    baptism_date { Faker::Date.between(10.years.ago, Date.today) }
    membership_date { Faker::Date.between(10.years.ago, Date.today) }
    discipline_date { Faker::Date.between(10.years.ago, Date.today) }
    transfer_date { Faker::Date.between(10.years.ago, Date.today) }
    family
    church
  end
end
