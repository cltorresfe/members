class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update]

  # GET /profile
  def edit
  end

  # PUT /profile
  def update
    params[:user][:church_attributes][:id] = current_church.id
    if @user.update(user_params)
      sign_in @user, :bypass => true
      redirect_to root_path, notice: t('.success')
    else
      render :edit
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = current_user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(
        :email, :password, :password_confirmation, :name,
        church_attributes: [:id, :name, :address, :email, :phone]
      )
    end
end
