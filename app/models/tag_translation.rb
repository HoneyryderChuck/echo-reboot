# -*- encoding : utf-8 -*-
class TagTranslation < ActiveRecord::Base
  belongs_to :tag

  has_enumerated :language

  validates :tag, :value, presence: true
  validates :value, uniqueness: { scope: [:tag_id, :language_code] }

  scope :with_value, proc { |value, lang_code=I18n.default_locale|
    where(arel_table[:language_code].eq(lang_code).and(arel_table[:value].eq(value)))
  }
  scope :with_values, proc { |list, lang_code=I18n.default_locale|
    where(arel_table[:language_code].eq(lang_code).and(arel_table[:value].eq_any(list)))
  }
  scope :with_value_like, proc { |value, lang_code=I18n.default_locale|
    where(arel_table[:language_code].eq(lang_code).and(arel_table[:value].matches("%#{value}%")))
  }
  scope :with_values_like, proc { |list, lang_code=I18n.default_locale|
    where(arel_table[:language_code].eq(lang_code).and(arel_table[:value].matches_any(list.map{|s| "%#{s}%"})))
  }
end