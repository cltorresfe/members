module Decorators
  module Member
    extend ActiveSupport::Concern

    included do
      def status_name
        self.class.get_status_name_for(status)
      end

      def self.statuses_for_select
        statuses.map { |k, v| [ get_status_name_for(k), k] }
      end

      def self.get_status_name_for(status)
        I18n.t("activerecord.attributes.member.status_name.#{status}", default: '')
      end
    end
  end
end
