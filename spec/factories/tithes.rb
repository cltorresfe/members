# == Schema Information
#
# Table name: tithes
#
#  id         :integer          not null, primary key
#  handed_at  :datetime
#  quantity   :decimal(, )
#  member_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  church_id  :integer
#

FactoryGirl.define do
  factory :tithe do
    handed_at 2.days.ago
    quantity '9.99'
    member
    church
  end
end
