# == Schema Information
#
# Table name: members
#
#  id         :integer          not null, primary key
#  name       :string
#  address    :string
#  email      :string
#  phone      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  church_id  :integer
#  status     :integer
#

FactoryGirl.define do
  factory :member do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    address { Faker::Address.street_address }
    email { Faker::Internet.email }
    gender true
    phone '123456789'
    status :active
    church
  end
end
