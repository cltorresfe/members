module Decorators
  module Member
    extend ActiveSupport::Concern

    included do
      def status_name
        self.class.get_status_name_for(status)
      end

      def self.statuses_for_select
        statuses.map { |k, _v| [get_status_name_for(k), k] }
      end

      def self.get_status_name_for(status)
        I18n.t("activerecord.attributes.member.status_name.#{status}",
               default: '')
      end

      def role_name
        self.class.get_role_name_for(role)
      end

      def self.role_for_select
        roles.map { |k, _v| [get_role_name_for(k), k] }
      end

      def self.get_role_name_for(role)
        I18n.t("activerecord.attributes.member.role_name.#{role}", default: '')
      end

      def country_name
        iso_country = ISO3166::Country[country]
        iso_country.translations[I18n.locale.to_s] || iso_country.name
      end

      def full_name
        "#{first_name} #{last_name}"
      end

      def full_name_and_mail
        "#{first_name} #{last_name} <#{email}>"
      end

      def semi_full_name
        "#{first_name} #{last_name.first + '.' if last_name}"
      end

      def facebook_url
        "https://www.facebook.com/#{facebook}"
      end

      def twitter_url
        "https://www.twitter.com/#{twitter}"
      end

      def avatar_url(version = nil)
        if avatar?
          avatar.url(version)
        else
          case gender
          when true then 'default_avatar_female.png'
          when false then 'default_avatar_male.png'
          when nil then 'default_avatar.png'
          end
        end
      end
    end
  end
end
