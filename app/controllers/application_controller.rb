class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!, :has_church_assigned
  helper_method :current_church

  def authenticate_active_admin!
    unless current_user && current_user.admin?
      redirect_to root_path
    end
  end

  def current_church
    current_user.church if current_user
  end

  def has_church_assigned
    if current_user && current_church.blank? && !%w(churches sessions).include?(controller_name)
      redirect_to new_church_path
    end
  end
end
