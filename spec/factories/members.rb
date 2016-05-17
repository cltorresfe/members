# == Schema Information
#
# Table name: members
#
#  id         :integer          not null, primary key
#  name       :string
#  address    :string
#  email      :string
#  phone      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  church_id  :integer
#  status     :integer
#

FactoryGirl.define do
  factory :member do
    name 'Homero'
    address 'Springfield'
    email 'homero@simpsons.com'
    phone 123456789
    status :active
    church
  end
end
