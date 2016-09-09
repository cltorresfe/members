class AttendanceMailer < ApplicationMailer
  def attendances_confirmation(attendance_date, ministry_id, user_id)
    @user = User.find(user_id)
    @ministry = Ministry.find(ministry_id)
    @attendance_date = Date.parse(attendance_date)
    @attendances = Attendance.present.by_date_and_ministry(
      @attendance_date, ministry_id
    )
    @percent_attendances = @ministry.percent_attendances_by_date(
      @attendance_date, @attendance_date
    )
    mail bcc: Member.administrative_for_ministry(ministry_id).pluck(:email),
         subject: I18n.t('attendance_mailer.attendances_confirmation.subject')
  end
end
