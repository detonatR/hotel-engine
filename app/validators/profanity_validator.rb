# frozen_string_literal: true

class ProfanityValidator < ActiveModel::EachValidator
  BLACKLIST = I18n.t('profanity.blacklist')

  def validate_each(record, attribute, value)
    return if value.blank?

    check_profanity(record, attribute, value)
  end

  private

  def check_profanity(record, attribute, value)
    record.errors.add(attribute, :profane) if profane?(value)
  end

  def profane?(value)
    BLACKLIST.each do |profanity|
      return true if value =~ /\b#{profanity}\b/i
    end

    false
  end
end
