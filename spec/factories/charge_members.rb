# == Schema Information
#
# Table name: charge_members
#
#  id         :integer          not null, primary key
#  charge_id  :integer
#  member_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null

FactoryGirl.define do
  factory :charge_member do
    charge
    member
  end
end
