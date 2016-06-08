# == Schema Information
#
# Table name: attendances
#
#  id              :integer          not null, primary key
#  member_id       :integer
#  ministry_id     :integer
#  attendance_date :datetime
#  present         :boolean
#  created_at      :datetime         not null
#  updated_at      :datetime         not null

FactoryGirl.define do
  factory :attendance do
    member
    ministry
    attendance_date 2.days.ago
    present true
  end
end
