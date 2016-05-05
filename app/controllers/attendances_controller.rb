class AttendancesController < ApplicationController

  def index
    @current_ministry = params[:ministry_id] ? Ministry.find(params[:ministry_id]) : Ministry.first
    @attendance_date = params[:attendance_date] || Date.today.strftime('%d/%m/%Y')
    @attendances = Attendance.where(ministry: @current_ministry, attendance_date: Date.parse(@attendance_date).beginning_of_day)
    @charges = @current_ministry.charges.non_administrative
    @ministries = Ministry.all
  end

  def create
    attendances = params[:attendance]
    if attendances && attendances.any?
      attendances.each do |attendance_params|
        attendance = Attendance.find_or_initialize_by(
          member_id: attendance_params[:member_id],
          ministry_id: params[:ministry_id],
          attendance_date: Date.parse(params[:attendance_date]).beginning_of_day
        )
        attendance.present = attendance_params[:present].present?
        attendance.save
      end
    end
    redirect_to action: :index, attendance_date: params[:attendance_date], ministry_id: params[:ministry_id]
  end

  private

    def attendance_params
      params.require(:attendance).permit(:member_id, :ministry_id, :attendance_date, :present)
    end
end
