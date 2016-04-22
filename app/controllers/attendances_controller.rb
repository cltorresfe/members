class AttendancesController < InheritedResources::Base

  private

    def attendance_params
      params.require(:attendance).permit(:member_id, :ministry_id, :attendance_date, :present)
    end
end

