# == Schema Information
#
# Table name: churches
#
#  id         :integer          not null, primary key
#  name       :string
#  address    :string
#  email      :string
#  phone      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :church do
    name 'Inglesia'
    address 'Springfield'
    email 'Inglesia@simpsons.com'
    phone 123456789
  end
end
