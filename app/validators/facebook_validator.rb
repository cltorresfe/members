class FacebookValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /^[a-z\d.]{5,}$/i
      record.errors.add(attribute, :invalid)
    end
  end
end