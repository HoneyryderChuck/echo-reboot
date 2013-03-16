# -*- encoding : utf-8 -*-
FactoryGirl.define do
  factory :spoken_language do
    association :user, factory: :user
    language_code { Language.codes.sample }
    language_level_code { LanguageLevel.codes.sample }
  end
end