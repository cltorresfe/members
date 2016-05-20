class ApplicationController < ActionController::Base
  include Pundit
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :exception
  before_filter :set_locale, :authenticate_user!, :clear_flash

  def authenticate_active_admin!
    unless current_user && current_user.admin?
      redirect_to root_path
    end
  end

  private

    def set_locale
      I18n.locale = params[:locale] || I18n.default_locale
    end

    def default_url_options(options = {})
      {locale: I18n.locale}
    end

    def clear_flash
      flash.clear
    end
end
