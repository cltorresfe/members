class AttendanceMailer < ApplicationMailer

  def attendances_confirmation(attendance_date, ministry_id, user_id)
    @user = User.find(user_id)
    @ministry = Ministry.find(ministry_id)
    @administrative_members = Member.administrative_for_ministry(ministry_id).with_email
    @attendance_date = Date.parse(attendance_date)
    @present_attendances = Attendance.present.by_date_and_ministry(attendance_date, ministry_id)
    @absent_attendances = Attendance.absent.by_date_and_ministry(attendance_date, ministry_id)

    mail bcc: @administrative_members.pluck(:email), subject: I18n.t('attendance_mailer.attendances_confirmation.subject')
  end
end
