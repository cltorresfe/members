# == Schema Information
#
# Table name: ministries
#
#  id          :integer          not null, primary key
#  name        :string
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  church_id   :integer

FactoryGirl.define do
  factory :ministry do
    name { Faker::Company.name }
    description { Faker::Lorem.sentence }
    church
    responsibilities {[FactoryGirl.create(:responsibility)]}
  end
end
