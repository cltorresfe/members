class ChurchesController < ApplicationController
  # GET /churches/new
  def new
    if current_church.blank?
      @church = Church.new
    else
      redirect_to root_path, alert: t('.new_church_not_allowed')
    end
  end

  # POST /churches
  def create
    @church = Church.new(church_params)
    @church.users << current_user
    if @church.save
      redirect_to root_path, notice: 'Church was successfully created.'
    else
      render :new
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def church_params
    params.require(:church).permit(:name, :address, :email, :phone)
  end
end
