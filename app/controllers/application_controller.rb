class ApplicationController < ActionController::Base
  # include Pundit
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

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
    if current_user && current_church.blank? && controller_name != 'churches' && !['new', 'create'].include?( action_name )
      redirect_to new_church_path
    end
  end

end
