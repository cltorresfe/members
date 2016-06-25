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

  scope :present, -> { where(present: true ) }
  scope :absent, -> { where(present: false) }

  before_validation :format_date

  def self.attendances_last_week(church)
    joins(:ministry).
    joins("left join churches on ministries.church_id = churches.id").
    group(:attendance_date).select('attendances.attendance_date, count (*)').
    where("churches.id = ?",church.id).
    where("attendances.attendance_date > ?", 1.week.ago).
    where(present: true).
    order('attendances.attendance_date')
  end

  def self.by_date_and_ministry(attendance_date, ministry_id)
    where(attendance_date: attendance_date, ministry_id: ministry_id)
  end

  def self.by_attendance_date
    order('attendance_date desc')
  end

  def format_date
    self.attendance_date = self.attendance_date.beginning_of_day if self.attendance_date.present?
  end

  def human_present
    I18n.t("members.show.#{present ? 'present' : 'absent'}")
  end

end
