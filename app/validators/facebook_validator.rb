class FacebookValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add(attribute, :invalid) unless value =~ /^[a-z\d.]{5,}$/i
  end
end
