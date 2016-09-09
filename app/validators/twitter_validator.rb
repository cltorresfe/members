class TwitterValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /^[A-Za-z0-9_]{1,15}$/
      record.errors.add(attribute, :invalid)
    end
  end
end
