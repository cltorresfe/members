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
    if member.avatar?
      image_tag member.avatar.url(:thumb), class:'img-circle img-container', width: size
    else
      imagen_file = case member.gender
              when true then "default_avatar_female.png"
              when false then "default_avatar_male.png"
              when nil then "default_avatar.png"
              end
      image_tag imagen_file, class:'img-circle img-container', width: size

    end

  end

end
