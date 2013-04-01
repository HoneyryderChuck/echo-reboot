# -*- encoding : utf-8 -*-
class SpokenLanguage < ActiveRecord::Base
  belongs_to :user

  has_enumerated :language
  has_enumerated :language_level

  validates :user, :language_code, :language_level_code, presence: true
  validates :language_code, uniqueness: { scope: :user_id }

  LanguageLevel.codes.each do |code|
    scope :"#{code}", proc { where(language_level_code: code ) }
    valuable_codes = LanguageLevel.codes.slice(0, LanguageLevel.codes.index(code)+1)
    scope :"at_least_#{code}", proc { where(language_level_code: valuable_codes) }
  end

  scope :by_language_level, proc { order("FIND_IN_SET(language_level_code, '#{LanguageLevel.codes.join(",")}')")}
end