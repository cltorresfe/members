module ApplicationHelper

  def get_title
    subtitle = content_for?(:title) ? content_for(:title) : i18n_title
    "#{ "#{subtitle} - " unless subtitle.blank?}#{t('application')}"
  end

  def i18n_title
    I18n.t "#{controller.controller_name}.#{controller.action_name}.title", default: ''
  end

  def prioritary_countries
    %w(CL)
  end

  def avatar_for(member, options = { size: 80})
    size = options[:size]
    image_tag member.avatar_url(:thumb), class:'img-circle img-container', width: size
  end

  def image_for(member, options = { size: 80})
    size = options[:size]
    image_tag member.avatar_url, class:'img img-responsive avatar-view', width: size
  end

end
