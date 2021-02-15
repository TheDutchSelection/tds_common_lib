class EmailValidator < ::ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i || value.nil? || value == ''
      record.errors.add attribute, (options[:message] || I18n.t('validators.email.not_valid'))
    end
  end
end
