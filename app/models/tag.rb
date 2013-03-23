# -*- encoding : utf-8 -*-
class Tag < ActiveRecord::Base

  has_many :tao_tags, dependent: :destroy
  has_many :tag_translations, dependent: :destroy

  def locale(locale = I18n.locale)
    tag_translations.where(language_code: [locale, I18n.default_locale]).first.value
  end

end