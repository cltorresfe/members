module ApplicationHelper

  def get_title
    subtitle = content_for?(:title) ? content_for(:title) : i18n_title
    "#{ "#{subtitle} - " unless subtitle.blank?} #{t('application')}"
  end

  def i18n_title
    I18n.t "#{controller.controller_name}.#{controller.action_name}.title", default: ''
  end
end
