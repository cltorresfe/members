module Decorators
  module Member
    extend ActiveSupport::Concern

    included do
      def status_name
        self.class.get_status_name_for(status)
      end

      def self.statuses_for_select
        statuses.map { |k, _v| [ get_status_name_for(k), k] }
      end

      def self.get_status_name_for(status)
        I18n.t("activerecord.attributes.member.status_name.#{status}", default: '')
      end

      def country_name
        iso_country = ISO3166::Country[country]
        iso_country.translations[I18n.locale.to_s] || iso_country.name
      end

      def full_name
        "#{first_name} #{last_name}"
      end

      def semi_full_name
        "#{first_name} #{last_name.first + '.' if last_name}"
      end
    end
  end
end
