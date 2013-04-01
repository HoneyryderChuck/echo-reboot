# -*- encoding : utf-8 -*-
class CollectionEmptinessValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << I18n.t("errors.messages.collection_empty", attribute: record.class.human_attribute_name(attribute)) if value.size == 0
  end
end