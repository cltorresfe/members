class AttendancesController < ApplicationController

  def index
    # @attendance = Attendance.new
    @current_ministry = params[:ministry_id] ? Ministry.find(params[:ministry_id]) : Ministry.first
    @attendance_date = params[:attendance_date] || Date.today.strftime('%d/%m/%Y')
    @attendances = Attendance.where(ministry: @current_ministry, attendance_date: @attendance_date)
    @charges = @current_ministry.charges.non_administrative

    @ministries = Ministry.all
  end

  def create
    redirect_to action: :index
  end

  private

    def attendance_params
      params.require(:attendance).permit(:member_id, :ministry_id, :attendance_date, :present)
    end
end
