# == Schema Information
#
# Table name: families
#
#  id         :integer          not null, primary key
#  name       :string
#  married_at :datetime
#  address    :string
#  phone      :string
#  city       :string
#  country    :string
#  church_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :family do
    name 'MyString'
    married_at '2016-05-20 10:49:30'
    address 'MyString'
    phone 'MyString'
    city 'MyString'
    country 'MyString'
    church
  end
end
