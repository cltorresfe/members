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
#

FactoryGirl.define do
  factory :member do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    address { Faker::Address.street_address }
    email { Faker::Internet.email }
    phone '123456789'
    status :active
    church
  end
end
