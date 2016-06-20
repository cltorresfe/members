class AttendancesController < ApplicationController

  def index
    @current_ministry = params[:ministry_id] ? Ministry.find(params[:ministry_id]) : current_user.church.ministries.first
    @attendance_date = params[:attendance_date] || Date.current.strftime('%d/%m/%Y')
    @attendances = Attendance.where(ministry: @current_ministry, attendance_date: Date.parse(@attendance_date).beginning_of_day)
    @ministries = current_user.church.ministries
    if(@current_ministry.present?)
      @charges = @current_ministry.charges.non_administrative
    else
      flash.now[:notice] = t('.not_found', url: new_ministry_path)
    end
  end

  def create
    attendances = params[:attendance]
    attendance_date = Date.parse(params[:attendance_date])
    if attendances && attendances.any?
      attendances.each do |attendance_params|
        attendance = Attendance.find_or_initialize_by(
          member_id: attendance_params[:member_id],
          ministry_id: params[:ministry_id],
          attendance_date: attendance_date
        )
        attendance.present = attendance_params[:present].present?
        attendance.save
      end
      AttendanceMailer.attendances_confirmation(attendance_date, params[:ministry_id], current_user.id).deliver_now if params[:send_mail].present?
    end

    redirect_to action: :index, attendance_date: params[:attendance_date], ministry_id: params[:ministry_id]
  end

  private

    def attendance_params
      params.require(:attendance).permit(:member_id, :ministry_id, :attendance_date, :present)
    end
end
