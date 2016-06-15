module ChangeFormatPhone
  extend ActiveSupport::Concern

  def change_to_format_phone
    self.phone = phone.gsub(/\D/, '') if attribute_present?("phone")
  end
end
