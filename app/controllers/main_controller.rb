class MainController < ApplicationController
  def index
    @members = current_user.church.members
    @ministries = current_user.church.ministries
    @responsibilities = Responsibility.by_church(current_user.church)
    @families = current_user.church.families
    gon.attendances_week = Attendance.attendances_last_week(current_user.church)
    gon.members_gender = current_user.church.members.by_gender
    gon.members_range = current_user.church.members.by_range
    @members_last = @members.last(8)
    @members_birth_date = @members.birth_date_by_month
    @families_married_date = @families.married_notification_by_month
  end
end
