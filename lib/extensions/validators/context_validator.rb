# -*- encoding : utf-8 -*-
class ContextValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value.map(&:tag_context_code).any?{|context| not options[:in].include?(context) }
      record.errors[attribute] << I18n.t("errors.messages.invalid_context")
    end
  end
end