class AttendanceMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.attendance_mailer.attendances_confirmation.subject
  #
  def attendances_confirmation(attendance)
    @greeting = "Hi"
    @attendance = attendance

    mail to: @attendance.member.email, subject: "Confirmación de registro de asistencia"
  end
end
