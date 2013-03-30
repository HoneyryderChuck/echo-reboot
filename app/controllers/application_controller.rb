class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_locale



  private
  # sets the locale to be used for the translations
  # strategy: cookie language -> if user, user preferred language -> default language
  def set_locale
    I18n.locale = if cookies[:locale].present? and I18n.available_locales.include?(cookies[:locale])
      cookies[:locale]
    elsif user_signed_in?
      current_user.preferred_language
    else
      http_accept_language.compatible_language_from(I18n.available_locales)
    end
  end

end
