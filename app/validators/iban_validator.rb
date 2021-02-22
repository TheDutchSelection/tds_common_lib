require 'iban-tools'

class IbanValidator < ::ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless IBANTools::IBAN.valid?(value) || value.nil? || value == ''
      record.errors.add attribute, (options[:message] || I18n.t('validators.iban.not_valid'))
    end
  end
end
