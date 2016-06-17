class ApplicationController < ActionController::Base
  # include Pundit
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :exception
  before_action :authenticate_user!, :has_church_assigned

  def authenticate_active_admin!
    unless current_user && current_user.admin?
      redirect_to root_path
    end
  end

  def has_church_assigned
    if current_user && current_user.church.blank? && controller_name != 'churches' && !['new', 'create'].include?( action_name )
      redirect_to new_church_path
    end
  end

end
