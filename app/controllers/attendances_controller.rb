class AttendancesController < ApplicationController

  def index
    # @attendance = Attendance.new
    @ministries = Ministry.all
    @current_ministry = params[:ministry_id] ? Ministry.find(params[:ministry_id]) : Ministry.first
    @attendance_date = params[:attendance_date] || Date.today
  end

  private

    def attendance_params
      params.require(:attendance).permit(:member_id, :ministry_id, :attendance_date, :present)
    end
end
