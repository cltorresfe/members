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
#

class Attendance < ApplicationRecord
  belongs_to :member
  belongs_to :ministry

  def self.attendances_last_week(church)
    joins(:ministry).
    joins("left join churches on ministries.church_id = churches.id").
    group(:attendance_date).select('attendance_date, count (*)').
    where("churches.id = ?",church.id).
    where("attendances.attendance_date > ?", 1.week.ago).
    where(present: true).
    order('attendances.attendance_date')
  end
end
