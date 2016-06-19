class MainController < ApplicationController
  def index
    @members = current_church.members
    @ministries = current_church.ministries
    @responsibilities = Responsibility.by_church(current_church)
    @families = current_church.families
    @attendances = Attendance.attendances_last_week(current_church)
    @members_last = @members.last(8)
    @members_birth_date = @members.birth_date_by_month
    @families_married_date = @families.married_notification_by_month

    gon.attendances_week = @attendances if @attendances.present?
    gon.members_gender = current_church.members.by_gender
    gon.members_range = current_church.members.by_range
  end
end
