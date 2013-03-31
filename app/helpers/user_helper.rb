# -*- encoding : utf-8 -*-
module UserHelper
  def languages_by_proficiency(user, level)
    languages = user.spoken_languages.send(:"at_least_#{level}").map(&:language)
    languages.empty? ? Array(Language[I18n.locale]) : languages
  end
end