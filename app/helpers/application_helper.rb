module ApplicationHelper
  include UserHelper

  def language_preference_list
    priority_languages = [I18n.locale]
    # insert user spoken languages into the priority languages
    priority_languages += current_user.spoken_languages.by_language_level.pluck(:language_code) if current_user
    # insert original language in the priority languages; in case everything else fails, we show the original document
    priority_languages <<  @statement.node.original_language.code if @statement.present?
    priority_languages.uniq
  end
end
